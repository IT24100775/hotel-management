
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useUser } from "@/contexts/UserContext";
import { usePayment, Payment } from "@/contexts/PaymentContext";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Separator } from "@/components/ui/separator";
import { CreditCard, Calendar, CheckCircle } from "lucide-react";
import { toast } from "@/hooks/use-toast";

const Checkout = () => {
  const navigate = useNavigate();
  const { user } = useUser();
  const { addPayment } = usePayment();
  
  const [selectedRoom, setSelectedRoom] = useState({
    id: "room-1",
    name: "Deluxe Ocean View",
    hotel: "Grand Seaside Resort",
    price: 249.99,
    image: "https://images.unsplash.com/photo-1566665797739-1674de7a421a?q=80&w=2574&auto=format&fit=crop"
  });
  
  const [checkIn, setCheckIn] = useState("");
  const [checkOut, setCheckOut] = useState("");
  const [paymentMethod, setPaymentMethod] = useState<"credit_card" | "paypal">("credit_card");
  const [cardInfo, setCardInfo] = useState({
    number: "",
    name: "",
    expiry: "",
    cvc: ""
  });
  const [isProcessing, setIsProcessing] = useState(false);
  const [isPaymentComplete, setIsPaymentComplete] = useState(false);
  
  const calculateTotal = () => {
    if (!checkIn || !checkOut) return selectedRoom.price;
    
    const checkInDate = new Date(checkIn);
    const checkOutDate = new Date(checkOut);
    const nights = Math.max(1, Math.round((checkOutDate.getTime() - checkInDate.getTime()) / (1000 * 60 * 60 * 24)));
    
    return selectedRoom.price * nights;
  };
  
  const handleSubmitPayment = (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!checkIn || !checkOut) {
      toast({
        variant: "destructive",
        title: "Invalid Dates",
        description: "Please select valid check-in and check-out dates.",
      });
      return;
    }
    
    if (paymentMethod === "credit_card") {
      if (!cardInfo.number || cardInfo.number.length < 16 || 
          !cardInfo.name || !cardInfo.expiry || !cardInfo.cvc) {
        toast({
          variant: "destructive",
          title: "Invalid Card Information",
          description: "Please provide all required card details.",
        });
        return;
      }
    }
    
    setIsProcessing(true);
    
    // Simulate payment processing
    setTimeout(() => {
      try {
        const newPayment: Payment = {
          id: `pay-${Date.now().toString(36)}`,
          bookingId: `book-${Date.now().toString(36)}`,
          amount: calculateTotal(),
          currency: "USD",
          status: "completed",
          date: new Date().toISOString(),
          method: paymentMethod,
          cardDetails: paymentMethod === "credit_card" ? {
            last4: cardInfo.number.slice(-4),
            brand: "Visa"
          } : undefined,
          refundable: true,
          hotelName: selectedRoom.hotel,
          roomType: selectedRoom.name,
          checkIn,
          checkOut
        };
        
        addPayment(newPayment);
        setIsPaymentComplete(true);
        
        // Redirect after showing success message
        setTimeout(() => {
          navigate(`/payments/${newPayment.id}`);
        }, 2000);
        
      } catch (error) {
        console.error("Payment error:", error);
        toast({
          variant: "destructive",
          title: "Payment Failed",
          description: "There was an error processing your payment. Please try again.",
        });
        setIsProcessing(false);
      }
    }, 2000);
  };
  
  if (isPaymentComplete) {
    return (
      <div className="flex min-h-[70vh] items-center justify-center">
        <Card className="w-full max-w-md text-center">
          <CardHeader>
            <CheckCircle className="mx-auto mb-4 h-16 w-16 text-green-500" />
            <CardTitle className="text-2xl">Payment Successful!</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="mb-6 text-muted-foreground">
              Your booking has been confirmed. You will be redirected to your payment details shortly.
            </p>
            <div className="animate-pulse rounded-full bg-green-100 px-4 py-2 font-medium text-green-800">
              Processing your booking...
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }
  
  return (
    <div className="mx-auto max-w-4xl space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Complete Your Booking</h1>
        <p className="text-muted-foreground">Provide payment details to secure your room</p>
      </div>
      
      <div className="grid gap-6 lg:grid-cols-3">
        <div className="lg:col-span-2">
          <form onSubmit={handleSubmitPayment}>
            <Card>
              <CardHeader>
                <CardTitle>Booking Details</CardTitle>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="grid gap-4 sm:grid-cols-2">
                  <div>
                    <Label htmlFor="check-in">Check-in Date</Label>
                    <div className="relative mt-1">
                      <Calendar className="absolute left-3 top-3 h-4 w-4 text-gray-500" />
                      <Input
                        id="check-in"
                        type="date"
                        className="pl-10"
                        value={checkIn}
                        onChange={(e) => setCheckIn(e.target.value)}
                        min={new Date().toISOString().split('T')[0]}
                        required
                      />
                    </div>
                  </div>
                  <div>
                    <Label htmlFor="check-out">Check-out Date</Label>
                    <div className="relative mt-1">
                      <Calendar className="absolute left-3 top-3 h-4 w-4 text-gray-500" />
                      <Input
                        id="check-out"
                        type="date"
                        className="pl-10"
                        value={checkOut}
                        onChange={(e) => setCheckOut(e.target.value)}
                        min={checkIn || new Date().toISOString().split('T')[0]}
                        required
                      />
                    </div>
                  </div>
                </div>
                
                <Separator />
                
                <div>
                  <h3 className="mb-4 text-lg font-medium">Payment Method</h3>
                  <RadioGroup
                    value={paymentMethod}
                    onValueChange={(value) => setPaymentMethod(value as "credit_card" | "paypal")}
                    className="space-y-4"
                  >
                    <div className="flex items-center space-x-2 rounded-md border p-4 transition-colors hover:bg-muted/50">
                      <RadioGroupItem value="credit_card" id="card" />
                      <Label htmlFor="card" className="flex flex-1 cursor-pointer items-center gap-2">
                        <CreditCard className="h-4 w-4" /> Credit or Debit Card
                      </Label>
                    </div>
                    <div className="flex items-center space-x-2 rounded-md border p-4 transition-colors hover:bg-muted/50">
                      <RadioGroupItem value="paypal" id="paypal" />
                      <Label htmlFor="paypal" className="flex flex-1 cursor-pointer items-center gap-2">
                        <span className="text-sm font-bold text-blue-600">PayPal</span> Pay with PayPal
                      </Label>
                    </div>
                  </RadioGroup>
                </div>
                
                {paymentMethod === "credit_card" && (
                  <div className="space-y-4">
                    <div>
                      <Label htmlFor="card-number">Card Number</Label>
                      <Input
                        id="card-number"
                        placeholder="1234 5678 9012 3456"
                        value={cardInfo.number}
                        onChange={(e) => setCardInfo({...cardInfo, number: e.target.value.replace(/\D/g, '').slice(0, 16)})}
                        required
                      />
                    </div>
                    <div>
                      <Label htmlFor="card-name">Name on Card</Label>
                      <Input
                        id="card-name"
                        placeholder="John Smith"
                        value={cardInfo.name}
                        onChange={(e) => setCardInfo({...cardInfo, name: e.target.value})}
                        required
                      />
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                      <div>
                        <Label htmlFor="expiry">Expiry Date</Label>
                        <Input
                          id="expiry"
                          placeholder="MM/YY"
                          value={cardInfo.expiry}
                          onChange={(e) => {
                            const value = e.target.value.replace(/\D/g, '').slice(0, 4);
                            if (value.length > 2) {
                              setCardInfo({...cardInfo, expiry: `${value.slice(0,2)}/${value.slice(2)}`});
                            } else {
                              setCardInfo({...cardInfo, expiry: value});
                            }
                          }}
                          required
                        />
                      </div>
                      <div>
                        <Label htmlFor="cvc">CVC</Label>
                        <Input
                          id="cvc"
                          placeholder="123"
                          value={cardInfo.cvc}
                          onChange={(e) => setCardInfo({...cardInfo, cvc: e.target.value.replace(/\D/g, '').slice(0, 3)})}
                          required
                        />
                      </div>
                    </div>
                  </div>
                )}
                
                {paymentMethod === "paypal" && (
                  <div className="rounded-md border border-blue-100 bg-blue-50 p-4 text-center text-sm">
                    <p>You will be redirected to PayPal to complete your payment after clicking "Complete Booking".</p>
                  </div>
                )}
              </CardContent>
              <CardFooter className="flex justify-between">
                <Button variant="outline" type="button" onClick={() => navigate('/')}>Cancel</Button>
                <Button 
                  type="submit" 
                  className="bg-hotel-600 hover:bg-hotel-700" 
                  disabled={isProcessing}
                >
                  {isProcessing ? "Processing..." : "Complete Booking"}
                </Button>
              </CardFooter>
            </Card>
          </form>
        </div>
        
        <div>
          <Card>
            <CardHeader>
              <CardTitle>Booking Summary</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="overflow-hidden rounded-md">
                <img 
                  src={selectedRoom.image} 
                  alt={selectedRoom.name}
                  className="h-40 w-full object-cover"
                />
              </div>
              
              <div>
                <h3 className="font-semibold">{selectedRoom.hotel}</h3>
                <p className="text-muted-foreground">{selectedRoom.name}</p>
              </div>
              
              {checkIn && checkOut && (
                <div className="text-sm">
                  <p className="flex items-center gap-2">
                    <Calendar className="h-4 w-4" />
                    <span>Check-in: {new Date(checkIn).toLocaleDateString()}</span>
                  </p>
                  <p className="flex items-center gap-2">
                    <Calendar className="h-4 w-4" />
                    <span>Check-out: {new Date(checkOut).toLocaleDateString()}</span>
                  </p>
                  <p className="mt-1">
                    ({Math.round((new Date(checkOut).getTime() - new Date(checkIn).getTime()) / (1000 * 60 * 60 * 24))} nights)
                  </p>
                </div>
              )}
              
              <Separator />
              
              <div className="space-y-1">
                <div className="flex justify-between">
                  <span>Room price</span>
                  <span>${selectedRoom.price.toFixed(2)}/night</span>
                </div>
                {checkIn && checkOut && (
                  <div className="flex justify-between">
                    <span>Total for {Math.round((new Date(checkOut).getTime() - new Date(checkIn).getTime()) / (1000 * 60 * 60 * 24))} nights</span>
                    <span>${calculateTotal().toFixed(2)}</span>
                  </div>
                )}
              </div>
              
              <Separator />
              
              <div className="flex justify-between font-medium">
                <span>Total</span>
                <span>${calculateTotal().toFixed(2)}</span>
              </div>
              
              <div className="rounded-md border border-green-100 bg-green-50 p-2 text-center text-xs text-green-600">
                Free cancellation until 24 hours before check-in
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
};

export default Checkout;
