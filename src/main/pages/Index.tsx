
import { useUser } from "@/contexts/UserContext";
import { usePayment, Payment } from "@/contexts/PaymentContext";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { CreditCard, FileText, Star } from "lucide-react";
import { useState } from "react";
import { Link } from "react-router-dom";

const Index = () => {
  const { user } = useUser();
  const { payments, reviews } = usePayment();
  const [activeTab, setActiveTab] = useState<'payments' | 'reviews'>('payments');
  
  const recentPayments = payments.slice(0, 3);
  const userReviews = reviews.filter(review => review.userId === user?.id).slice(0, 3);
  
  const getStatusColor = (status: Payment['status']) => {
    switch (status) {
      case 'completed': return 'text-green-600 bg-green-50';
      case 'pending': return 'text-yellow-600 bg-yellow-50';
      case 'refunded': return 'text-blue-600 bg-blue-50';
      case 'failed': return 'text-red-600 bg-red-50';
      default: return 'text-gray-600 bg-gray-50';
    }
  };

  // Function to format currency in Sri Lankan Rupees
  const formatLKR = (amount: number) => {
    return `LKR ${amount.toLocaleString('en-LK')}`;
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Welcome, {user?.name}</h1>
          <p className="text-muted-foreground">Here's an overview of your hotel activity</p>
        </div>
        <div className="flex gap-4">
          <Link to="/checkout">
            <Button className="bg-orange-600 hover:bg-orange-700">Book a Room</Button>
          </Link>
        </div>
      </div>
      
      <div className="grid gap-6 md:grid-cols-3">
        <Card className="border-orange-200">
          <CardHeader className="flex flex-row items-center space-y-0 pb-2">
            <div className="h-10 w-10 rounded-full bg-orange-100 p-2">
              <CreditCard className="h-6 w-6 text-orange-600" />
            </div>
            <div className="ml-4">
              <CardTitle className="text-sm font-medium">Total Payments</CardTitle>
              <CardDescription>All time payments</CardDescription>
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatLKR(payments.reduce((sum, payment) => sum + payment.amount, 0))}</div>
            <p className="text-xs text-muted-foreground">{payments.length} transactions</p>
          </CardContent>
        </Card>
        
        <Card className="border-orange-200">
          <CardHeader className="flex flex-row items-center space-y-0 pb-2">
            <div className="h-10 w-10 rounded-full bg-amber-100 p-2">
              <Star className="h-6 w-6 text-amber-500" />
            </div>
            <div className="ml-4">
              <CardTitle className="text-sm font-medium">Reviews</CardTitle>
              <CardDescription>Your submitted reviews</CardDescription>
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{reviews.filter(review => review.userId === user?.id).length}</div>
            <p className="text-xs text-muted-foreground">Average rating: {
              reviews.filter(review => review.userId === user?.id).length > 0 
                ? (reviews.filter(review => review.userId === user?.id).reduce((sum, review) => sum + review.rating, 0) / 
                   reviews.filter(review => review.userId === user?.id).length).toFixed(1)
                : 'N/A'
            } / 5.0</p>
          </CardContent>
        </Card>
        
        <Card className="border-orange-200">
          <CardHeader className="flex flex-row items-center space-y-0 pb-2">
            <div className="h-10 w-10 rounded-full bg-green-100 p-2">
              <FileText className="h-6 w-6 text-green-600" />
            </div>
            <div className="ml-4">
              <CardTitle className="text-sm font-medium">Invoices</CardTitle>
              <CardDescription>Available for download</CardDescription>
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{payments.filter(p => p.status === 'completed').length}</div>
            <p className="text-xs text-muted-foreground">All downloadable as PDF</p>
          </CardContent>
        </Card>
      </div>

      <div>
        <div className="mb-4 flex space-x-4 border-b border-orange-200">
          <button 
            className={`border-b-2 pb-2 pt-2 ${activeTab === 'payments' ? 'border-orange-600 font-medium text-orange-600' : 'border-transparent text-gray-500 hover:text-gray-700'}`}
            onClick={() => setActiveTab('payments')}
          >
            Recent Payments
          </button>
          <button 
            className={`border-b-2 pb-2 pt-2 ${activeTab === 'reviews' ? 'border-orange-600 font-medium text-orange-600' : 'border-transparent text-gray-500 hover:text-gray-700'}`}
            onClick={() => setActiveTab('reviews')}
          >
            Your Reviews
          </button>
        </div>

        {activeTab === 'payments' && (
          recentPayments.length > 0 ? (
            <div className="space-y-4">
              {recentPayments.map((payment) => (
                <div key={payment.id} className="rounded-lg border border-orange-200 bg-card p-4">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="font-medium">{payment.hotelName}</p>
                      <p className="text-sm text-gray-500">{payment.roomType}</p>
                    </div>
                    <div className="text-right">
                      <p className="font-medium">{formatLKR(payment.amount)}</p>
                      <span className={`inline-block rounded-full px-2 py-1 text-xs ${getStatusColor(payment.status)}`}>
                        {payment.status.charAt(0).toUpperCase() + payment.status.slice(1)}
                      </span>
                    </div>
                  </div>
                  <div className="mt-2 flex items-center justify-between text-sm">
                    <p className="text-gray-500">
                      {new Date(payment.date).toLocaleDateString()} • {payment.method === 'credit_card' ? 'Card' : payment.method === 'paypal' ? 'PayPal' : 'Bank Transfer'}
                    </p>
                    <Link to={`/payments/${payment.id}`} className="text-orange-600 hover:underline">
                      View Details
                    </Link>
                  </div>
                </div>
              ))}
              <div className="text-center">
                <Link to="/payments">
                  <Button variant="outline" size="sm" className="border-orange-200 hover:bg-orange-50">View All Payments</Button>
                </Link>
              </div>
            </div>
          ) : (
            <div className="rounded-lg border border-orange-200 bg-card p-6 text-center">
              <p className="text-muted-foreground">No payment records found</p>
              <Link to="/checkout" className="mt-2 inline-block">
                <Button variant="outline" size="sm" className="border-orange-200 hover:bg-orange-50">Book a Room</Button>
              </Link>
            </div>
          )
        )}

        {activeTab === 'reviews' && (
          userReviews.length > 0 ? (
            <div className="space-y-4">
              {userReviews.map((review) => (
                <div key={review.id} className="rounded-lg border border-orange-200 bg-card p-4">
                  <div className="flex items-start justify-between">
                    <div>
                      <p className="font-medium">{review.hotelName}</p>
                      <p className="text-sm text-gray-500">{review.roomType}</p>
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
                    </div>
                    <div className="text-right">
                      <span className={`inline-block rounded-full px-2 py-1 text-xs ${review.approved ? 'bg-green-50 text-green-600' : 'bg-yellow-50 text-yellow-600'}`}>
                        {review.approved ? 'Published' : 'Pending'}
                      </span>
                    </div>
                  </div>
                  <div className="mt-2 text-right text-xs text-gray-500">
                    {new Date(review.date).toLocaleDateString()}
                  </div>
                </div>
              ))}
              <div className="text-center">
                <Link to="/reviews">
                  <Button variant="outline" size="sm" className="border-orange-200 hover:bg-orange-50">View All Reviews</Button>
                </Link>
              </div>
            </div>
          ) : (
            <div className="rounded-lg border border-orange-200 bg-card p-6 text-center">
              <p className="text-muted-foreground">You haven't submitted any reviews yet</p>
              <Link to="/reviews" className="mt-2 inline-block">
                <Button variant="outline" size="sm" className="border-orange-200 hover:bg-orange-50">Write a Review</Button>
              </Link>
            </div>
          )
        )}
      </div>
    </div>
  );
};

export default Index;
