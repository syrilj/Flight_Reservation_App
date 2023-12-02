package com.devrev.flightticketbooking.model;

import java.util.List;

interface SeatMapStrategy {
    List<String> generateSeatMap(int numberOfSeats);
}
