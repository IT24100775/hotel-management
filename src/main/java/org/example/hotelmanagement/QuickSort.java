package org.example.hotelmanagement;

import java.util.List;
import java.util.Date;

public class QuickSort {
    public static void sortBookingsByCheckInDate(List<Booking> bookings) {
        if (bookings == null || bookings.size() <= 1) {
            return;
        }
        quickSort(bookings, 0, bookings.size() - 1);
    }

    private static void quickSort(List<Booking> bookings, int low, int high) {
        if (low < high) {
            int pi = partition(bookings, low, high);
            quickSort(bookings, low, pi - 1);
            quickSort(bookings, pi + 1, high);
        }
    }

    private static int partition(List<Booking> bookings, int low, int high) {
        Date pivot = bookings.get(high).getCheckInDate();
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (bookings.get(j).getCheckInDate().compareTo(pivot) < 0) {
                i++;
                swap(bookings, i, j);
            }
        }
        swap(bookings, i + 1, high);
        return i + 1;
    }

    private static void swap(List<Booking> bookings, int i, int j) {
        Booking temp = bookings.get(i);
        bookings.set(i, bookings.get(j));
        bookings.set(j, temp);
    }
}