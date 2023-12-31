import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Paper, Typography, Button, withStyles } from '@material-ui/core';
import {useNavigate} from "react-router-dom";

const styles = (theme) => ({
    root: {
        padding: theme.spacing(4),
        backgroundColor: '#f5f5f5',
        borderRadius: '15px',
        boxShadow: '0px 0px 10px rgba(0, 0, 0, 0.1)',
        maxWidth: '800px',
        margin: 'auto',
    },
    sectionPaper: {
        marginBottom: theme.spacing(3),
        borderRadius: '15px',
        boxShadow: '0px 0px 5px rgba(0, 0, 0, 0.1)',
    },
    sectionHeader: {
        background: theme.palette.primary.main,
        color: '#fff',
        padding: theme.spacing(2),
        borderTopLeftRadius: '15px',
        borderTopRightRadius: '15px',
    },
    seatGrid: {
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fill, minmax(50px, 1fr))',
        gap: '10px',
        marginTop: theme.spacing(2),
        padding: theme.spacing(2),
        backgroundColor: '#fff',
        borderBottomLeftRadius: '15px',
        borderBottomRightRadius: '15px',
    },
    seat: {
        width: '30px',
        height: '30px',
        backgroundColor: '#ddd',
        borderRadius: '5px',
        textAlign: 'center',
        lineHeight: '30px',
        cursor: 'pointer',
    },
    priceContainer: {
        marginTop: theme.spacing(2),
        padding: theme.spacing(2),
        backgroundColor: '#fff',
        borderRadius: '0 0 15px 15px',
    },
    form: {
        marginTop: theme.spacing(2),
        textAlign: 'center',
    },
});

const SeatMap = ({ classes }) => {
    const navigate = useNavigate();
    const [flightNumber, setFlightNumber] = useState('');
    const [seatData, setSeatData] = useState({
        seatMap: [],
        seatPrices: {},
    });
    const [selectedSeat, setSelectedSeat] = useState(null);
    const [userData, setUserData] = useState(null);
    const [selectedFlightData, setSelectedFlightData] = useState(null);

    useEffect(() => {
        const storedUserData = localStorage.getItem('userData');
        const storedSelectedFlightData = localStorage.getItem('selectedFlight');

        if (storedUserData && storedSelectedFlightData) {
            setUserData(JSON.parse(storedUserData));
            setSelectedFlightData(JSON.parse(storedSelectedFlightData));
            setFlightNumber(JSON.parse(storedSelectedFlightData).flightno);
        }
    }, []);

    useEffect(() => {
        if (flightNumber) {
            const fetchSeatData = async () => {
                try {
                    const response = await axios.get(`http://localhost:8081/api/user/flight_seat_map/${flightNumber}`);
                    setSeatData(response.data);
                } catch (error) {
                    console.error('Error fetching seat data:', error);
                    setSeatData({ seatMap: [], seatPrices: {} });
                }
            };

            fetchSeatData();
        }
    }, [flightNumber]);

    const handleSeatClick = (section, seat) => {
        setSelectedSeat({ section, seat });
    };

    const handleSeatSelection = (e) => {
        e.preventDefault();

        try {
            const userData = JSON.parse(localStorage.getItem('userData'));

            if (!userData) {
                console.error('User data not available.');
                return;
            }

            console.log('Username:', userData.u_name);
            console.log('Selected Seat:', selectedSeat);

            const updatedFlightData = {
                ...selectedFlightData,
                selectedSeat: {
                    section: selectedSeat.section,
                    seat: selectedSeat.seat,
                    // Assuming "p_class" is the correct field name
                    p_class: selectedSeat.section === 'Business' ? 'Business' : 'Economy',
                },
            };

            // Update the flight data in localStorage with the selected seat information
            localStorage.setItem('selectedFlight', JSON.stringify(updatedFlightData));
            navigate("/bookflight")


            // Reset selected seat after successful selection
            setSelectedSeat(null);
        } catch (error) {
            console.error('Error selecting seat:', error);
        }
    };
    const renderSeatMap = () => {
        const { seatMap, seatPrices } = seatData;

        if (!seatMap.length || !seatPrices) {
            return <Typography variant="body1">No seat data available.</Typography>;
        }

        const sections = ['Ordinary', 'Comfort', 'Business'];

        const getSectionColor = (sectionType) => {
            switch (sectionType) {
                case 'Ordinary':
                    return '#FFD700'; // Gold
                case 'Business':
                    return '#87CEEB'; // Sky Blue
                case 'Comfort':
                    return '#98FB98'; // Pale Green
                default:
                    return '#FFF'; // Default White
            }
        };

        return (
            <div className={classes.root}>
                <Typography variant="h4" style={{ marginBottom: '20px', textAlign: 'center' }}>
                    Flight Seat Map - {flightNumber}
                </Typography>
                {sections.map((sectionType, index) => (
                    <Paper key={index} className={classes.sectionPaper}>
                        <Typography variant="h5" className={classes.sectionHeader} style={{ backgroundColor: getSectionColor(sectionType) }}>
                            {sectionType}
                        </Typography>
                        <div className={classes.seatGrid} style={{ backgroundColor: getSectionColor(sectionType) }}>
                            {Array.from({ length: seatMap[index] }).map((_, seatIndex) => (
                                <div
                                    key={seatIndex}
                                    className={classes.seat}
                                    onClick={() => handleSeatClick(sectionType, seatIndex + 1)}
                                    style={{
                                        backgroundColor:
                                            selectedSeat && selectedSeat.section === sectionType && selectedSeat.seat === seatIndex + 1 ? 'red' : '#ddd',
                                    }}
                                >
                                    {seatIndex + 1}
                                </div>
                            ))}
                        </div>
                        <div className={classes.priceContainer}>
                            <Typography variant="body1">{`Price: ${seatPrices[sectionType]}`}</Typography>
                        </div>
                    </Paper>
                ))}
            </div>
        );
    };


    return (
        <div>
            {renderSeatMap()}

            {selectedSeat && (
                <form onSubmit={handleSeatSelection} className={classes.form}>
                    <Typography variant="h5" style={{ marginTop: '20px' }}>
                        Selected Seat: {selectedSeat.section} - {selectedSeat.seat}
                    </Typography>
                    <Button variant="contained" color="primary" type="submit">
                        Confirm Seat Selection

                    </Button>
                </form>
            )}
        </div>
    );
};


export default withStyles(styles)(SeatMap);
