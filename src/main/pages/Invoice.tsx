
import { useEffect, useState } from "react";
import { useParams, Link, useNavigate } from "react-router-dom";
import { usePayment } from "@/contexts/PaymentContext";
import { Button } from "@/components/ui/button";
import { Download, ArrowLeft, CheckCircle } from "lucide-react";
import { useUser } from "@/contexts/UserContext";

const Invoice = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { getPaymentById } = usePayment();
  const { user } = useUser();
  const [payment, setPayment] = useState(getPaymentById(id || ""));
  const [isGenerating, setIsGenerating] = useState(false);
  const [downloadSuccess, setDownloadSuccess] = useState(false);

  useEffect(() => {
    if (!payment) {
      navigate("/payments");
    } else if (payment.status !== 'completed') {
      navigate(`/payments/${payment.id}`);
    }
  }, [payment, navigate]);

  if (!payment || payment.status !== 'completed') {
    return null;
  }

  const calculateNights = () => {
    const checkIn = new Date(payment.checkIn);
    const checkOut = new Date(payment.checkOut);
    return Math.round((checkOut.getTime() - checkIn.getTime()) / (1000 * 60 * 60 * 24));
  };

  const nights = calculateNights();
  const subtotal = payment.amount * 0.9;
  const tax = payment.amount * 0.1;

  const handleDownload = () => {
    setIsGenerating(true);
    
    // Simulate PDF generation delay
    setTimeout(() => {
      setIsGenerating(false);
      setDownloadSuccess(true);
      
      // Reset success message after a few seconds
      setTimeout(() => {
        setDownloadSuccess(false);
      }, 3000);
    }, 1500);
  };

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <div className="flex items-center justify-between">
        <Link to={`/payments/${payment.id}`} className="flex items-center gap-1 text-sm text-gray-500 hover:text-gray-700">
          <ArrowLeft className="h-4 w-4" />
          Back to Payment
        </Link>
        <Button
          onClick={handleDownload}
          disabled={isGenerating}
          className="gap-2"
        >
          {isGenerating ? (
            "Generating PDF..."
          ) : downloadSuccess ? (
            <>
              <CheckCircle className="h-4 w-4" />
              Downloaded
            </>
          ) : (
            <>
              <Download className="h-4 w-4" />
              Download PDF
            </>
          )}
        </Button>
      </div>

      <div className="invoice-border bg-white">
        <div className="p-8">
          <div className="flex justify-between">
            <div>
              <h1 className="text-3xl font-bold text-gray-800">Invoice</h1>
              <p className="text-gray-500">#{payment.id.toUpperCase()}</p>
            </div>
            <div className="text-right">
              <h2 className="text-xl font-bold text-hotel-700">HotelBooking.com</h2>
              <p className="text-gray-500">123 Hotel Street</p>
              <p className="text-gray-500">Cityville, HT 12345</p>
            </div>
          </div>

          <div className="mt-10 grid grid-cols-2 gap-8">
            <div>
              <h3 className="text-sm font-medium uppercase text-gray-500">Invoice To:</h3>
              <p className="mt-2 font-medium">{user?.name}</p>
              <p className="text-gray-500">{user?.email}</p>
            </div>
            <div className="text-right">
              <h3 className="text-sm font-medium uppercase text-gray-500">Invoice Details:</h3>
              <p className="mt-2"><span className="text-gray-500">Invoice Date:</span> {new Date(payment.date).toLocaleDateString()}</p>
              <p><span className="text-gray-500">Stay Period:</span> {new Date(payment.checkIn).toLocaleDateString()} to {new Date(payment.checkOut).toLocaleDateString()}</p>
              <p><span className="text-gray-500">Payment Method:</span> {
                payment.method === 'credit_card' 
                  ? `${payment.cardDetails?.brand} •••• ${payment.cardDetails?.last4}` 
                  : payment.method === 'paypal' 
                    ? 'PayPal' 
                    : 'Bank Transfer'
              }</p>
            </div>
          </div>

          <div className="mt-10">
            <h3 className="mb-4 text-sm font-medium uppercase text-gray-500">Booking Details</h3>
            <div className="overflow-hidden rounded-lg border border-gray-200">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th scope="col" className="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider text-gray-500">
                      Description
                    </th>
                    <th scope="col" className="px-6 py-3 text-center text-xs font-medium uppercase tracking-wider text-gray-500">
                      Nights
                    </th>
                    <th scope="col" className="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider text-gray-500">
                      Price
                    </th>
                    <th scope="col" className="px-6 py-3 text-right text-xs font-medium uppercase tracking-wider text-gray-500">
                      Amount
                    </th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-200 bg-white">
                  <tr>
                    <td className="whitespace-nowrap px-6 py-4">
                      <div>
                        <p className="font-medium text-gray-900">{payment.hotelName}</p>
                        <p className="text-sm text-gray-500">{payment.roomType}</p>
                      </div>
                    </td>
                    <td className="whitespace-nowrap px-6 py-4 text-center text-gray-500">
                      {nights}
                    </td>
                    <td className="whitespace-nowrap px-6 py-4 text-right text-gray-500">
                      ${(subtotal / nights).toFixed(2)}
                    </td>
                    <td className="whitespace-nowrap px-6 py-4 text-right text-gray-500">
                      ${subtotal.toFixed(2)}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <div className="mt-6 flex justify-end">
            <div className="w-80 space-y-2">
              <div className="flex justify-between border-b border-gray-100 pb-2">
                <p className="text-gray-600">Subtotal:</p>
                <p className="font-medium">${subtotal.toFixed(2)}</p>
              </div>
              <div className="flex justify-between border-b border-gray-100 pb-2">
                <p className="text-gray-600">Tax (10%):</p>
                <p className="font-medium">${tax.toFixed(2)}</p>
              </div>
              <div className="flex justify-between border-b-2 border-gray-900 pb-2 pt-2">
                <p className="text-lg font-medium">Total:</p>
                <p className="text-lg font-bold">${payment.amount.toFixed(2)}</p>
              </div>
            </div>
          </div>

          <div className="mt-10 border-t border-gray-100 pt-6 text-center">
            <p className="text-sm text-gray-500">Thank you for choosing HotelBooking.com</p>
            <p className="mt-1 text-xs text-gray-400">If you have any questions regarding this invoice, please contact our customer support.</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Invoice;
