
import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Index from "./pages/Index";
import NotFound from "./pages/NotFound";
import Layout from "./components/layout/Layout";
import Dashboard from "./pages/Dashboard";
import Payments from "./pages/Payments";
import PaymentDetail from "./pages/PaymentDetail";
import Invoice from "./pages/Invoice";
import Reviews from "./pages/Reviews";
import Checkout from "./pages/Checkout";
import Refunds from "./pages/Refunds";
import Admin from "./pages/Admin";
import { UserProvider } from "./contexts/UserContext";
import { PaymentProvider } from "./contexts/PaymentContext";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <UserProvider>
      <PaymentProvider>
        <TooltipProvider>
          <Toaster />
          <Sonner />
          <BrowserRouter>
            <Routes>
              <Route path="/" element={<Layout />}>
                <Route index element={<Index />} />
                <Route path="dashboard" element={<Dashboard />} />
                <Route path="payments" element={<Payments />} />
                <Route path="payments/:id" element={<PaymentDetail />} />
                <Route path="invoice/:id" element={<Invoice />} />
                <Route path="reviews" element={<Reviews />} />
                <Route path="checkout" element={<Checkout />} />
                <Route path="refunds" element={<Refunds />} />
                <Route path="admin" element={<Admin />} />
                <Route path="*" element={<NotFound />} />
              </Route>
            </Routes>
          </BrowserRouter>
        </TooltipProvider>
      </PaymentProvider>
    </UserProvider>
  </QueryClientProvider>
);

export default App;
