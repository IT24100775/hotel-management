
import { useState } from "react";
import { usePayment, Payment } from "@/contexts/PaymentContext";
import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { FileText, CreditCard, Download } from "lucide-react";

const Payments = () => {
  const { payments } = usePayment();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState<string>("all");

  const filteredPayments = payments
    .filter(payment => 
      (payment.hotelName.toLowerCase().includes(searchTerm.toLowerCase()) ||
       payment.roomType.toLowerCase().includes(searchTerm.toLowerCase()) ||
       payment.id.toLowerCase().includes(searchTerm.toLowerCase())) &&
      (statusFilter === "all" || payment.status === statusFilter)
    )
    .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());

  const getStatusColor = (status: Payment['status']) => {
    switch (status) {
      case 'completed': return 'text-green-600 bg-green-50';
      case 'pending': return 'text-yellow-600 bg-yellow-50';
      case 'refunded': return 'text-blue-600 bg-blue-50';
      case 'failed': return 'text-red-600 bg-red-50';
      default: return 'text-gray-600 bg-gray-50';
    }
  };

  const getPaymentMethodIcon = (method: Payment['method']) => {
    switch (method) {
      case 'credit_card':
        return <CreditCard className="h-4 w-4" />;
      case 'paypal':
        return <span className="text-xs font-bold text-blue-600">PayPal</span>;
      default:
        return <span className="text-xs">Bank</span>;
    }
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Payment History</h1>
        <p className="text-muted-foreground">View all your past transactions and download invoices</p>
      </div>

      <div className="flex flex-col items-center gap-4 sm:flex-row">
        <Input
          placeholder="Search by hotel or room..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="max-w-xs"
        />
        <Select value={statusFilter} onValueChange={setStatusFilter}>
          <SelectTrigger className="w-[180px]">
            <SelectValue placeholder="Filter by status" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Statuses</SelectItem>
            <SelectItem value="completed">Completed</SelectItem>
            <SelectItem value="pending">Pending</SelectItem>
            <SelectItem value="refunded">Refunded</SelectItem>
            <SelectItem value="failed">Failed</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <div className="space-y-4">
        {filteredPayments.length > 0 ? (
          filteredPayments.map((payment) => (
            <div key={payment.id} className="rounded-lg border bg-card shadow-sm">
              <div className="p-6">
                <div className="flex flex-col justify-between gap-4 sm:flex-row sm:items-center">
                  <div>
                    <p className="font-medium">{payment.hotelName}</p>
                    <p className="text-sm text-gray-500">{payment.roomType}</p>
                    <div className="mt-1 flex items-center gap-2">
                      <span className="inline-flex items-center gap-1 rounded-full border bg-white px-2 py-1 text-xs">
                        {getPaymentMethodIcon(payment.method)}
                        {payment.method === 'credit_card' && payment.cardDetails ? 
                          <span>•••• {payment.cardDetails.last4}</span> : null}
                      </span>
                      <span className="text-xs text-gray-500">
                        {new Date(payment.date).toLocaleDateString()}
                      </span>
                    </div>
                  </div>
                  <div className="text-right">
                    <p className="text-xl font-semibold">${payment.amount.toFixed(2)}</p>
                    <span className={`mt-1 inline-block rounded-full px-2 py-1 text-xs ${getStatusColor(payment.status)}`}>
                      {payment.status.charAt(0).toUpperCase() + payment.status.slice(1)}
                    </span>
                  </div>
                </div>
              </div>
              <div className="flex items-center justify-between border-t bg-gray-50 px-6 py-3">
                <div className="text-sm text-gray-500">
                  ID: {payment.id}
                </div>
                <div className="flex gap-2">
                  {payment.status === 'completed' && (
                    <Link to={`/invoice/${payment.id}`}>
                      <Button size="sm" variant="outline" className="gap-1">
                        <Download className="h-4 w-4" />
                        Invoice
                      </Button>
                    </Link>
                  )}
                  <Link to={`/payments/${payment.id}`}>
                    <Button size="sm" className="gap-1">View Details</Button>
                  </Link>
                </div>
              </div>
            </div>
          ))
        ) : (
          <div className="flex flex-col items-center rounded-lg border bg-card p-10 text-center">
            <FileText className="mb-4 h-12 w-12 text-gray-300" />
            <h3 className="mb-2 text-lg font-semibold">No payments found</h3>
            <p className="text-muted-foreground">
              {searchTerm || statusFilter !== "all" 
                ? "Try adjusting your search or filter criteria."
                : "You haven't made any payments yet."}
            </p>
            {searchTerm || statusFilter !== "all" ? (
              <Button 
                variant="outline" 
                className="mt-4"
                onClick={() => {
                  setSearchTerm("");
                  setStatusFilter("all");
                }}
              >
                Clear Filters
              </Button>
            ) : (
              <Link to="/checkout">
                <Button className="mt-4 bg-hotel-600 hover:bg-hotel-700">Book a Room</Button>
              </Link>
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default Payments;
