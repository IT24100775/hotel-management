
import React, { createContext, useContext, useState, ReactNode } from 'react';

interface User {
  id: string;
  name: string;
  email: string;
  avatar: string;
}

interface UserContextType {
  user: User | null;
  login: (email: string, password: string) => Promise<boolean>;
  logout: () => void;
  isAuthenticated: boolean;
}

const UserContext = createContext<UserContextType | undefined>(undefined);

export const useUser = () => {
  const context = useContext(UserContext);
  if (context === undefined) {
    throw new Error('useUser must be used within a UserProvider');
  }
  return context;
};

export const UserProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(() => {
    const storedUser = localStorage.getItem('hotelUser');
    return storedUser ? JSON.parse(storedUser) : {
      id: 'user-1',
      name: 'John Smith',
      email: 'john@example.com',
      avatar: 'https://i.pravatar.cc/150?img=68'
    };
  });

  const login = async (email: string, password: string): Promise<boolean> => {
    try {
      // This would be replaced with an actual API call to your Java backend
      console.log('Login attempt with:', email, password);
      
      const mockUser = {
        id: 'user-1',
        name: 'John Smith',
        email: email,
        avatar: 'https://i.pravatar.cc/150?img=68'
      };
      
      setUser(mockUser);
      localStorage.setItem('hotelUser', JSON.stringify(mockUser));
      return true;
    } catch (error) {
      console.error('Login failed:', error);
      return false;
    }
  };

  const logout = () => {
    setUser(null);
    localStorage.removeItem('hotelUser');
  };

  return (
    <UserContext.Provider value={{ 
      user, 
      login, 
      logout, 
      isAuthenticated: !!user 
    }}>
      {children}
    </UserContext.Provider>
  );
};
