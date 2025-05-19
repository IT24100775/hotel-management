
import { useState } from "react";
import { useUser } from "@/contexts/UserContext";
import { usePayment, Payment, Review } from "@/contexts/PaymentContext";
import { Table, TableHeader, TableBody, TableRow, TableHead, TableCell } from "@/components/ui/table";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { toast } from "@/hooks/use-toast";
import { CreditCard, Star, MessageSquare, CheckCircle, AlertCircle } from "lucide-react";
import { Navigate } from "react-router-dom";

const Admin = () => {
  const { user } = useUser();
  const { payments, reviews, requestRefund, approveReview } = usePayment();
  const [paymentFilter, setPaymentFilter] = useState("all");
  const [reviewFilter, setReviewFilter] = useState("pending");
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedReview, setSelectedReview] = useState<Review | null>(null);
  const [adminResponse, setAdminResponse] = useState("");
  const [responseDialogOpen, setResponseDialogOpen] = useState(false);
  
  // Simple admin check - in a real app, you would check for admin role
  const isAdmin = user?.id === "user-1"; // Assuming user-1 is admin for demo purposes
  
  if (!isAdmin) {
    return <Navigate to="/dashboard" replace />;
  }

  const filteredPayments = payments.filter(payment => {
    const matchesSearch = (
      payment.hotelName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      payment.id.toLowerCase().includes(searchTerm.toLowerCase())
    );
    
    if (paymentFilter === "all") return matchesSearch;
    return payment.status === paymentFilter && matchesSearch;
  });
  
  const filteredReviews = reviews.filter(review => {
    const matchesSearch = (
      review.hotelName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      review.userName.toLowerCase().includes(searchTerm.toLowerCase())
    );
    
    if (reviewFilter === "all") return matchesSearch;
    if (reviewFilter === "pending") return !review.approved && matchesSearch;
    if (reviewFilter === "approved") return review.approved && matchesSearch;
    return matchesSearch;
  });

  const handleRefund = async (paymentId: string) => {
    const success = await requestRefund(paymentId);
    if (success) {
      toast({
        title: "Refund Processed",
        description: "The refund has been successfully processed.",
      });
    } else {
      toast({
        variant: "destructive",
        title: "Refund Failed",
        description: "There was an error processing the refund.",
      });
    }
  };

  const openResponseDialog = (review: Review) => {
    setSelectedReview(review);
    setResponseDialogOpen(true);
    setAdminResponse(review.adminResponse || "");
  };

  const handleApproveReview = () => {
    if (!selectedReview) return;
    
    approveReview(selectedReview.id, adminResponse);
    toast({
      title: "Review Approved",
      description: "The review has been approved and published.",
    });
    setResponseDialogOpen(false);
    setAdminResponse("");
    setSelectedReview(null);
  };

  function getStatusColor(status: Payment['status']) {
    switch (status) {
      case 'completed': return 'bg-green-50 text-green-700';
      case 'pending': return 'bg-yellow-50 text-yellow-700';
      case 'refunded': return 'bg-blue-50 text-blue-700';
      case 'failed': return 'bg-red-50 text-red-700';
      default: return 'bg-gray-50 text-gray-700';
    }
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Admin Dashboard</h1>
        <p className="text-muted-foreground">Manage payments and reviews for the hotel booking system</p>
      </div>

      <div className="flex items-center space-x-4">
        <Input
          placeholder="Search..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="max-w-xs"
        />
      </div>

      <Tabs defaultValue="payments" className="space-y-4">
        <TabsList>
          <TabsTrigger value="payments" className="flex items-center gap-2">
            <CreditCard className="h-4 w-4" />
            Payments
          </TabsTrigger>
          <TabsTrigger value="reviews" className="flex items-center gap-2">
            <Star className="h-4 w-4" />
            Reviews
          </TabsTrigger>
        </TabsList>
        
        <TabsContent value="payments" className="space-y-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <div>
                <CardTitle className="text-xl font-bold">Payment Management</CardTitle>
                <CardDescription>Manage all customer payments and refunds</CardDescription>
              </div>
              <Select value={paymentFilter} onValueChange={setPaymentFilter}>
                <SelectTrigger className="w-[180px]">
                  <SelectValue placeholder="Filter by status" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Payments</SelectItem>
                  <SelectItem value="completed">Completed</SelectItem>
                  <SelectItem value="pending">Pending</SelectItem>
                  <SelectItem value="refunded">Refunded</SelectItem>
                  <SelectItem value="failed">Failed</SelectItem>
                </SelectContent>
              </Select>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>ID</TableHead>
                    <TableHead>Customer</TableHead>
                    <TableHead>Hotel</TableHead>
                    <TableHead>Amount</TableHead>
                    <TableHead>Status</TableHead>
                    <TableHead>Date</TableHead>
                    <TableHead>Action</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredPayments.length > 0 ? (
                    filteredPayments.map((payment) => (
                      <TableRow key={payment.id}>
                        <TableCell className="font-medium">{payment.id}</TableCell>
                        <TableCell>-</TableCell>
                        <TableCell>{payment.hotelName} ({payment.roomType})</TableCell>
                        <TableCell>${payment.amount.toFixed(2)}</TableCell>
                        <TableCell>
                          <Badge variant="outline" className={getStatusColor(payment.status)}>
                            {payment.status.charAt(0).toUpperCase() + payment.status.slice(1)}
                          </Badge>
                        </TableCell>
                        <TableCell>{new Date(payment.date).toLocaleDateString()}</TableCell>
                        <TableCell>
                          {payment.status === 'completed' && payment.refundable && (
                            <Button
                              variant="outline"
                              size="sm"
                              onClick={() => handleRefund(payment.id)}
                            >
                              Process Refund
                            </Button>
                          )}
                        </TableCell>
                      </TableRow>
                    ))
                  ) : (
                    <TableRow>
                      <TableCell colSpan={7} className="h-24 text-center">
                        <div className="flex flex-col items-center justify-center space-y-2">
                          <AlertCircle className="h-8 w-8 text-gray-400" />
                          <div className="text-sm text-gray-500">No payments found</div>
                        </div>
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>
        
        <TabsContent value="reviews" className="space-y-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <div>
                <CardTitle className="text-xl font-bold">Review Management</CardTitle>
                <CardDescription>Approve and moderate customer reviews</CardDescription>
              </div>
              <Select value={reviewFilter} onValueChange={setReviewFilter}>
                <SelectTrigger className="w-[180px]">
                  <SelectValue placeholder="Filter reviews" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Reviews</SelectItem>
                  <SelectItem value="pending">Pending Approval</SelectItem>
                  <SelectItem value="approved">Approved</SelectItem>
                </SelectContent>
              </Select>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredReviews.length > 0 ? (
                  filteredReviews.map((review) => (
                    <Card key={review.id} className="overflow-hidden">
                      <CardContent className="p-6">
                        <div className="flex items-start justify-between">
                          <div className="flex items-start space-x-4">
                            <Avatar>
                              <AvatarImage src={review.userAvatar} alt={review.userName} />
                              <AvatarFallback>{review.userName[0]}</AvatarFallback>
                            </Avatar>
                            <div>
                              <div className="flex items-center space-x-2">
                                <p className="font-medium">{review.userName}</p>
                                <span className="text-xs text-muted-foreground">
                                  {new Date(review.date).toLocaleDateString()}
                                </span>
                              </div>
                              <div className="mt-1 flex">
                                {[1, 2, 3, 4, 5].map((star) => (
                                  <Star
                                    key={star}
                                    size={16}
                                    className={star <= review.rating ? "fill-amber-400 text-amber-400" : "text-gray-300"}
                                  />
                                ))}
                              </div>
                              <p className="mt-2 text-sm">{review.comment}</p>
                              <div className="mt-2 text-xs text-gray-500">
                                <span className="font-medium">Hotel:</span> {review.hotelName} - {review.roomType}
                              </div>
                              {review.approved && review.adminResponse && (
                                <div className="mt-3 rounded-md bg-gray-50 p-3 text-sm text-gray-700">
                                  <p className="font-medium mb-1">Admin Response:</p>
                                  <p>{review.adminResponse}</p>
                                </div>
                              )}
                            </div>
                          </div>
                          <div>
                            <Badge variant={review.approved ? "outline" : "secondary"} className="mb-2">
                              {review.approved ? "Approved" : "Pending"}
                            </Badge>
                            {!review.approved && (
                              <div className="flex justify-end">
                                <Button 
                                  size="sm" 
                                  className="gap-1"
                                  onClick={() => openResponseDialog(review)}
                                >
                                  <CheckCircle className="h-4 w-4" />
                                  Approve
                                </Button>
                              </div>
                            )}
                            {review.approved && !review.adminResponse && (
                              <div className="flex justify-end">
                                <Button 
                                  size="sm"
                                  variant="outline" 
                                  className="gap-1"
                                  onClick={() => openResponseDialog(review)}
                                >
                                  <MessageSquare className="h-4 w-4" />
                                  Add Response
                                </Button>
                              </div>
                            )}
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  ))
                ) : (
                  <div className="rounded-lg border border-dashed p-6 text-center">
                    <AlertCircle className="mx-auto mb-2 h-10 w-10 text-muted-foreground" />
                    <h3 className="mb-1 font-medium">No Reviews Found</h3>
                    <p className="text-sm text-muted-foreground">
                      {reviewFilter === "pending"
                        ? "All reviews have been approved."
                        : "There are no reviews matching your criteria."}
                    </p>
                  </div>
                )}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      {/* Admin Response Dialog */}
      <Dialog open={responseDialogOpen} onOpenChange={setResponseDialogOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>
              {selectedReview?.approved ? "Add Response to Review" : "Approve Review"}
            </DialogTitle>
          </DialogHeader>
          <div className="space-y-4">
            {selectedReview && (
              <div className="rounded-lg border bg-gray-50 p-4">
                <div className="flex items-center space-x-2">
                  <Avatar className="h-8 w-8">
                    <AvatarImage src={selectedReview.userAvatar} alt={selectedReview.userName} />
                    <AvatarFallback>{selectedReview.userName[0]}</AvatarFallback>
                  </Avatar>
                  <div>
                    <p className="font-medium">{selectedReview.userName}</p>
                    <div className="flex">
                      {[1, 2, 3, 4, 5].map((star) => (
                        <Star
                          key={star}
                          size={14}
                          className={star <= selectedReview.rating ? "fill-amber-400 text-amber-400" : "text-gray-300"}
                        />
                      ))}
                    </div>
                  </div>
                </div>
                <p className="mt-2 text-sm">{selectedReview.comment}</p>
              </div>
            )}
            
            <div>
              <label className="mb-2 block text-sm font-medium">Response{selectedReview?.approved ? "" : " (Optional)"}</label>
              <Textarea
                placeholder="Add a response to this review..."
                value={adminResponse}
                onChange={(e) => setAdminResponse(e.target.value)}
                rows={4}
              />
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setResponseDialogOpen(false)}>
              Cancel
            </Button>
            <Button 
              onClick={handleApproveReview}
              className="bg-hotel-600 hover:bg-hotel-700"
            >
              {selectedReview?.approved ? "Update Response" : "Approve & Publish"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default Admin;
