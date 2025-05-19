
import { useEffect, useState } from "react";
import { useParams, Link, useNavigate } from "react-router-dom";
import { usePayment } from "@/contexts/PaymentContext";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Calendar, CreditCard, FileText, AlertTriangle, CheckCircle } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { toast } from "@/hooks/use-toast";
import { Separator } from "@/components/ui/separator";

const PaymentDetail = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { getPaymentById, requestRefund } = usePayment();
  const [payment, setPayment] = useState(getPaymentById(id || ""));
  const [isRefundDialogOpen, setIsRefundDialogOpen] = useState(false);
  const [isRefunding, setIsRefunding] = useState(false);
  const [refundSuccess, setRefundSuccess] = useState(false);

  useEffect(() => {
    if (!payment) {
      navigate("/payments");
    }
  }, [payment, navigate]);

  if (!payment) {
    return null;
  }

  const handleRefundRequest = async () => {
    setIsRefunding(true);
    try {
      const success = await requestRefund(payment.id);
      if (success) {
        setRefundSuccess(true);
        setTimeout(() => {
          setIsRefundDialogOpen(false);
          setPayment(getPaymentById(payment.id));
          toast({
            title: "Refund Processed",
            description: "Your refund has been successfully processed.",
          });
        }, 2000);
      } else {
        toast({
          variant: "destructive",
          title: "Refund Failed",
          description: "There was an error processing your refund. Please try again.",
        });
        setIsRefunding(false);
      }
    } catch (error) {
      console.error("Refund error:", error);
      setIsRefunding(false);
    }
  };

  const getStatusBadgeColor = () => {
    switch (payment.status) {
      case 'completed': return 'bg-green-100 text-green-800';
      case 'pending': return 'bg-yellow-100 text-yellow-800';
      case 'refunded': return 'bg-blue-100 text-blue-800';
      case 'failed': return 'bg-red-100 text-red-800';
      default: return 'bg-gray-100 text-gray-800';
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <div className="flex items-center gap-2">
            <Link to="/payments" className="text-sm text-gray-500 hover:text-gray-700">
              Payments
            </Link>
            <span className="text-sm text-gray-500">›</span>
            <span className="text-sm">Payment Details</span>
          </div>
          <h1 className="mt-2 text-2xl font-bold tracking-tight">Payment #{payment.id}</h1>
        </div>
        <div className="flex gap-2">
          {payment.status === 'completed' && (
            <Link to={`/invoice/${payment.id}`}>
              <Button variant="outline" className="gap-2">
                <FileText className="h-4 w-4" />
                View Invoice
              </Button>
            </Link>
          )}
          {payment.refundable && payment.status === 'completed' && (
            <Button 
              variant="outline" 
              className="border-red-200 text-red-600 hover:bg-red-50 hover:text-red-700"
              onClick={() => setIsRefundDialogOpen(true)}
            >
              Request Refund
            </Button>
          )}
        </div>
      </div>

      <div className="rounded-lg border">
        <div className="border-b bg-muted/40 px-6 py-4">
          <h2 className="font-semibold">Payment Information</h2>
        </div>
        <div className="p-6">
          <div className="grid gap-6 md:grid-cols-2">
            <div>
              <h3 className="mb-2 text-sm font-medium">Booking Details</h3>
              <div className="space-y-2 rounded-lg border bg-white p-4">
                <p className="font-medium">{payment.hotelName}</p>
                <p className="text-sm text-gray-600">{payment.roomType}</p>
                <div className="flex items-center gap-2 text-sm text-gray-500">
                  <Calendar className="h-4 w-4" />
                  {new Date(payment.checkIn).toLocaleDateString()} - {new Date(payment.checkOut).toLocaleDateString()}
                </div>
              </div>
            </div>

            <div>
              <h3 className="mb-2 text-sm font-medium">Payment Details</h3>
              <div className="space-y-2 rounded-lg border bg-white p-4">
                <div className="flex items-center justify-between">
                  <span>Amount:</span>
                  <span className="font-medium">${payment.amount.toFixed(2)} {payment.currency}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span>Date:</span>
                  <span>{new Date(payment.date).toLocaleString()}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span>Status:</span>
                  <Badge className={getStatusBadgeColor()}>
                    {payment.status.charAt(0).toUpperCase() + payment.status.slice(1)}
                  </Badge>
                </div>
              </div>
            </div>

            <div>
              <h3 className="mb-2 text-sm font-medium">Payment Method</h3>
              <div className="space-y-2 rounded-lg border bg-white p-4">
                {payment.method === 'credit_card' && payment.cardDetails ? (
                  <>
                    <div className="flex items-center">
                      <div className="mr-3 flex h-8 w-12 items-center justify-center rounded border bg-white">
                        <CreditCard className="h-5 w-5 text-gray-500" />
                      </div>
                      <div>
                        <p className="font-medium">{payment.cardDetails.brand}</p>
                        <p className="text-sm text-gray-600">•••• •••• •••• {payment.cardDetails.last4}</p>
                      </div>
                    </div>
                  </>
                ) : payment.method === 'paypal' ? (
                  <div className="flex items-center">
                    <div className="mr-3 flex h-8 w-12 items-center justify-center rounded border bg-white">
                      <span className="text-sm font-bold text-blue-600">PayPal</span>
                    </div>
                    <p className="font-medium">PayPal</p>
                  </div>
                ) : (
                  <div className="flex items-center">
                    <div className="mr-3 flex h-8 w-12 items-center justify-center rounded border bg-white">
                      <span className="text-xs">Bank</span>
                    </div>
                    <p className="font-medium">Bank Transfer</p>
                  </div>
                )}
              </div>
            </div>

            <div>
              <h3 className="mb-2 text-sm font-medium">Invoice</h3>
              <div className="space-y-2 rounded-lg border bg-white p-4">
                <div className="flex items-center justify-between">
                  <span>Invoice ID:</span>
                  <span>INV-{payment.id.toUpperCase()}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span>Available for Download:</span>
                  <span>{payment.status === 'completed' ? 'Yes' : 'No'}</span>
                </div>
                {payment.status === 'completed' && (
                  <div className="mt-3">
                    <Link to={`/invoice/${payment.id}`}>
                      <Button size="sm" variant="outline" className="w-full gap-2">
                        <FileText className="h-4 w-4" />
                        View Invoice
                      </Button>
                    </Link>
                  </div>
                )}
              </div>
            </div>
          </div>

          {payment.status === 'refunded' && (
            <div className="mt-6 rounded-lg border border-blue-200 bg-blue-50 p-4 text-blue-800">
              <div className="flex items-center gap-2">
                <CheckCircle className="h-5 w-5" />
                <p className="font-medium">This payment has been refunded</p>
              </div>
              <p className="mt-1 text-sm">The refund has been processed and should be credited back to your original payment method.</p>
            </div>
          )}
        </div>
      </div>

      {/* Refund Confirmation Dialog */}
      <Dialog open={isRefundDialogOpen} onOpenChange={setIsRefundDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Request Refund</DialogTitle>
            <DialogDescription>
              {refundSuccess ? (
                <div className="py-4 text-center">
                  <CheckCircle className="mx-auto mb-2 h-12 w-12 text-green-500" />
                  <p className="text-lg font-medium text-green-600">Refund Successfully Processed</p>
                  <p className="mt-1 text-gray-500">Your refund has been initiated and will be credited back to your original payment method.</p>
                </div>
              ) : (
                <>
                  <p className="mt-2">
                    Are you sure you want to request a refund for your booking at {payment.hotelName}?
                  </p>
                  <div className="mt-4 rounded-lg border p-4">
                    <h4 className="font-medium">Refund Details</h4>
                    <Separator className="my-2" />
                    <div className="space-y-2 text-sm">
                      <div className="flex justify-between">
                        <span>Booking ID:</span>
                        <span>{payment.bookingId}</span>
                      </div>
                      <div className="flex justify-between">
                        <span>Amount to be refunded:</span>
                        <span className="font-medium">${payment.amount.toFixed(2)} {payment.currency}</span>
                      </div>
                      <div className="flex justify-between">
                        <span>Refund method:</span>
                        <span>Original payment method</span>
                      </div>
                    </div>
                  </div>
                  <div className="mt-4 flex items-start gap-2 rounded-lg bg-amber-50 p-3 text-amber-800">
                    <AlertTriangle className="mt-0.5 h-5 w-5 flex-shrink-0" />
                    <div className="text-sm">
                      <p className="font-medium">Please note:</p>
                      <p>Refunds can take 5-10 business days to appear on your statement depending on your payment provider.</p>
                    </div>
                  </div>
                </>
              )}
            </DialogDescription>
          </DialogHeader>
          {!refundSuccess && (
            <DialogFooter>
              <Button 
                variant="outline" 
                onClick={() => setIsRefundDialogOpen(false)}
                disabled={isRefunding}
              >
                Cancel
              </Button>
              <Button 
                variant="destructive"
                onClick={handleRefundRequest}
                disabled={isRefunding}
              >
                {isRefunding ? "Processing..." : "Confirm Refund"}
              </Button>
            </DialogFooter>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default PaymentDetail;
