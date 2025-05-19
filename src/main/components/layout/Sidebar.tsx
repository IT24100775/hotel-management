
import { Link, useLocation } from "react-router-dom";
import { cn } from "@/lib/utils";
import { useUser } from "@/contexts/UserContext";
import { Button } from "../ui/button";
import { 
  CalendarCheck, 
  CalendarMinus, 
  CreditCard, 
  FileText, 
  History, 
  Star,
  Home,
  LogOut,
  Settings
} from "lucide-react";
import { Avatar, AvatarFallback, AvatarImage } from "../ui/avatar";

const navItems = [
  { href: '/', icon: Home, label: 'Home' },
  { href: '/dashboard', icon: CalendarCheck, label: 'Dashboard' },
  { href: '/payments', icon: CreditCard, label: 'Payments' },
  { href: '/reviews', icon: Star, label: 'Reviews' },
  { href: '/refunds', icon: CalendarMinus, label: 'Refunds' },
];

const Sidebar = () => {
  const location = useLocation();
  const { user, logout } = useUser();
  
  // Simple check if user is admin (in a real app, you would use roles)
  const isAdmin = user?.id === "user-1";

  return (
    <aside className="fixed inset-y-0 left-0 z-50 hidden w-64 shrink-0 border-r border-gray-200 bg-white md:sticky md:flex md:w-64 md:flex-col">
      <div className="flex flex-col overflow-y-auto pt-5">
        <div className="mb-8 flex items-center px-4">
          <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-hotel-600">
            <span className="text-lg font-bold text-white">H</span>
          </div>
          <span className="ml-2 text-lg font-bold text-gray-900">HotelBooking</span>
        </div>

        <div className="mb-8 px-4">
          {user && (
            <div className="flex items-center space-x-3">
              <Avatar>
                <AvatarImage src={user.avatar} alt={user.name} />
                <AvatarFallback>{user.name[0]}</AvatarFallback>
              </Avatar>
              <div>
                <p className="font-medium">{user.name}</p>
                <p className="text-xs text-gray-500">{user.email}</p>
              </div>
            </div>
          )}
        </div>

        <div className="flex-1 space-y-1 px-2">
          {navItems.map((item) => (
            <Link
              key={item.href}
              to={item.href}
              className={cn(
                "flex items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium transition-all",
                location.pathname === item.href
                  ? "bg-hotel-50 text-hotel-700"
                  : "text-gray-700 hover:bg-hotel-50 hover:text-hotel-700"
              )}
            >
              <item.icon size={18} />
              {item.label}
            </Link>
          ))}
          
          {/* Admin section - only shown if user is admin */}
          {isAdmin && (
            <>
              <div className="my-2 px-3 text-xs font-semibold text-gray-500">ADMIN</div>
              <Link
                to="/admin"
                className={cn(
                  "flex items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium transition-all",
                  location.pathname === "/admin"
                    ? "bg-hotel-50 text-hotel-700"
                    : "text-gray-700 hover:bg-hotel-50 hover:text-hotel-700"
                )}
              >
                <Settings size={18} />
                Admin Dashboard
              </Link>
            </>
          )}
        </div>
        
        <div className="border-t border-gray-200 px-2 py-4">
          <Button 
            onClick={() => logout()}
            variant="ghost"
            className="flex w-full items-center justify-start gap-3 px-3 py-2 text-sm text-gray-700 hover:bg-hotel-50 hover:text-hotel-700"
          >
            <LogOut size={18} />
            Sign Out
          </Button>
        </div>
      </div>
    </aside>
  );
};

export default Sidebar;
