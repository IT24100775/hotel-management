
import React, { createContext, useContext, useState, ReactNode } from 'react';

export interface Payment {
  id: string;
  bookingId: string;
  amount: number;
  currency: string;
  status: 'completed' | 'pending' | 'refunded' | 'failed';
  date: string;
  method: 'credit_card' | 'paypal' | 'bank_transfer';
  cardDetails?: {
    last4: string;
    brand: string;
  };
  refundable: boolean;
  hotelName: string;
  roomType: string;
  checkIn: string;
  checkOut: string;
}

export interface Review {
  id: string;
  bookingId: string;
  userId: string;
  userName: string;
  userAvatar: string;
  rating: number;
  comment: string;
  date: string;
  hotelName: string;
  roomType: string;
  approved: boolean;
  adminResponse?: string;
}

interface PaymentContextType {
  payments: Payment[];
  reviews: Review[];
  addPayment: (payment: Payment) => void;
  requestRefund: (paymentId: string) => Promise<boolean>;
  getPaymentById: (id: string) => Payment | undefined;
  addReview: (review: Omit<Review, 'id' | 'approved' | 'date'>) => void;
  approveReview: (reviewId: string, adminResponse?: string) => void;
  getUserReviews: (userId: string) => Review[];
}

const PaymentContext = createContext<PaymentContextType | undefined>(undefined);

export const usePayment = () => {
  const context = useContext(PaymentContext);
  if (context === undefined) {
    throw new Error('usePayment must be used within a PaymentProvider');
  }
  return context;
};

export const PaymentProvider = ({ children }: { children: ReactNode }) => {
  const [payments, setPayments] = useState<Payment[]>([
    {
      id: 'pay-1',
      bookingId: 'book-1',
      amount: 349.99,
      currency: 'USD',
      status: 'completed',
      date: '2025-04-15T10:30:00Z',
      method: 'credit_card',
      cardDetails: {
        last4: '4242',
        brand: 'Visa'
      },
      refundable: true,
      hotelName: 'Grand Seaside Resort',
      roomType: 'Deluxe Ocean View',
      checkIn: '2025-05-10',
      checkOut: '2025-05-15'
    },
    {
      id: 'pay-2',
      bookingId: 'book-2',
      amount: 189.50,
      currency: 'USD',
      status: 'completed',
      date: '2025-03-22T14:15:00Z',
      method: 'paypal',
      refundable: false,
      hotelName: 'Mountain View Lodge',
      roomType: 'Standard Double Room',
      checkIn: '2025-04-05',
      checkOut: '2025-04-08'
    },
    {
      id: 'pay-3',
      bookingId: 'book-3',
      amount: 875.00,
      currency: 'USD',
      status: 'refunded',
      date: '2025-02-17T09:45:00Z',
      method: 'credit_card',
      cardDetails: {
        last4: '1234',
        brand: 'Mastercard'
      },
      refundable: false,
      hotelName: 'City Center Suites',
      roomType: 'Executive Suite',
      checkIn: '2025-03-12',
      checkOut: '2025-03-19'
    }
  ]);
  
  const [reviews, setReviews] = useState<Review[]>([
    {
      id: 'rev-1',
      bookingId: 'book-1',
      userId: 'user-1',
      userName: 'John Smith',
      userAvatar: 'https://i.pravatar.cc/150?img=68',
      rating: 4,
      comment: 'Wonderful stay with great amenities. The ocean view was breathtaking. Service was excellent throughout our stay.',
      date: '2025-05-17T11:30:00Z',
      hotelName: 'Grand Seaside Resort',
      roomType: 'Deluxe Ocean View',
      approved: true
    },
    {
      id: 'rev-2',
      bookingId: 'book-2',
      userId: 'user-1',
      userName: 'John Smith',
      userAvatar: 'https://i.pravatar.cc/150?img=68',
      rating: 3,
      comment: 'Decent stay. Room was clean but a bit small. Location is convenient for hiking trails.',
      date: '2025-04-10T15:45:00Z',
      hotelName: 'Mountain View Lodge',
      roomType: 'Standard Double Room',
      approved: true,
      adminResponse: 'Thank you for your feedback. We appreciate your comments about our location and will consider your suggestions for improving our standard rooms.'
    }
  ]);

  const addPayment = (payment: Payment) => {
    setPayments(prev => [...prev, payment]);
  };

  const requestRefund = async (paymentId: string): Promise<boolean> => {
    try {
      // This would be replaced with an actual API call to your Java backend
      setPayments(prev => prev.map(payment => 
        payment.id === paymentId 
          ? { ...payment, status: 'refunded', refundable: false } 
          : payment
      ));
      return true;
    } catch (error) {
      console.error('Refund request failed:', error);
      return false;
    }
  };

  const getPaymentById = (id: string) => {
    return payments.find(payment => payment.id === id);
  };

  const addReview = (reviewData: Omit<Review, 'id' | 'approved' | 'date'>) => {
    const newReview: Review = {
      ...reviewData,
      id: `rev-${reviews.length + 1}`,
      approved: false,
      date: new Date().toISOString()
    };
    setReviews(prev => [...prev, newReview]);
  };

  const approveReview = (reviewId: string, adminResponse?: string) => {
    setReviews(prev => prev.map(review => 
      review.id === reviewId 
        ? { ...review, approved: true, adminResponse } 
        : review
    ));
  };

  const getUserReviews = (userId: string) => {
    return reviews.filter(review => review.userId === userId);
  };

  return (
    <PaymentContext.Provider value={{
      payments,
      reviews,
      addPayment,
      requestRefund,
      getPaymentById,
      addReview,
      approveReview,
      getUserReviews
    }}>
      {children}
    </PaymentContext.Provider>
  );
};
