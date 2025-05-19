
import { useState } from "react";
import { usePayment } from "@/contexts/PaymentContext";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { CalendarMinus, FileText } from "lucide-react";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { format } from "date-fns";
import { Link } from "react-router-dom";

const Refunds = () => {
  const { payments } = usePayment();
  const [statusFilter, setStatusFilter] = useState<string>("all");
  
  const refundablePayments = payments.filter(payment => payment.refundable && payment.status === 'completed');
  const refundedPayments = payments.filter(payment => payment.status === 'refunded');
  
  const filteredRefunds = statusFilter === "refundable" 
    ? refundablePayments
    : statusFilter === "refunded" 
      ? refundedPayments
      : [...refundablePayments, ...refundedPayments];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Refund Management</h1>
        <p className="text-muted-foreground">View refundable bookings and past refunds</p>
      </div>

      <div className="flex items-center gap-4">
        <Select value={statusFilter} onValueChange={setStatusFilter}>
          <SelectTrigger className="w-[180px]">
            <SelectValue placeholder="Status" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All</SelectItem>
            <SelectItem value="refundable">Refundable</SelectItem>
            <SelectItem value="refunded">Refunded</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Refund Eligible Bookings</CardTitle>
        </CardHeader>
        <CardContent>
          {filteredRefunds.length > 0 ? (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Booking Details</TableHead>
                  <TableHead>Amount</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead>Date</TableHead>
                  <TableHead className="text-right">Actions</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filteredRefunds.map((payment) => (
                  <TableRow key={payment.id}>
                    <TableCell>
                      <div className="font-medium">{payment.hotelName}</div>
                      <div className="text-sm text-gray-500">{payment.roomType}</div>
                    </TableCell>
                    <TableCell className="font-medium">
                      ${payment.amount.toFixed(2)}
                    </TableCell>
                    <TableCell>
                      <div className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium ${
                        payment.status === 'refunded' 
                          ? 'bg-blue-100 text-blue-800' 
                          : 'bg-green-100 text-green-800'
                        }`}
                      >
                        {payment.status === 'refunded' ? 'Refunded' : 'Refundable'}
                      </div>
                    </TableCell>
                    <TableCell>
                      {format(new Date(payment.date), 'MMM dd, yyyy')}
                    </TableCell>
                    <TableCell className="text-right">
                      {payment.status === 'refunded' ? (
                        <Link to={`/payments/${payment.id}`}>
                          <Button size="sm" variant="outline">
                            View Details
                          </Button>
                        </Link>
                      ) : (
                        <Link to={`/payments/${payment.id}`}>
                          <Button size="sm" variant="outline" className="text-red-600">
                            Request Refund
                          </Button>
                        </Link>
                      )}
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          ) : (
            <div className="flex flex-col items-center rounded-lg border border-dashed p-10 text-center">
              <CalendarMinus className="mb-4 h-12 w-12 text-gray-300" />
              <h3 className="mb-2 text-lg font-semibold">No refunds found</h3>
              <p className="text-muted-foreground">
                {statusFilter === "refundable" 
                  ? "You don't have any bookings eligible for refunds."
                  : statusFilter === "refunded" 
                    ? "You haven't requested any refunds yet."
                    : "No refunds or refundable bookings found."}
              </p>
              <Button variant="outline" className="mt-4" onClick={() => setStatusFilter("all")}>
                Clear Filters
              </Button>
            </div>
          )}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Refund Policy</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <p>Our hotel refund policy allows for cancellations and refunds under the following conditions:</p>
          <ul className="ml-6 list-disc space-y-1">
            <li>Full refunds are available for cancellations made at least 24 hours before check-in time.</li>
            <li>Partial refunds (50%) may be available for cancellations made less than 24 hours before check-in, at management discretion.</li>
            <li>No refunds are provided for no-shows or cancellations after check-in time has passed.</li>
            <li>Special events and peak season bookings may have different refund policies as noted during booking.</li>
          </ul>
          <p className="mt-4">For any questions regarding refunds, please contact our customer support team.</p>
        </CardContent>
      </Card>
    </div>
  );
};

export default Refunds;
