// SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

contract dairbnb {
    //events
    event userCreated(
        string name,
        string dateOfBirth,
        string country,
        bytes32 hashedPassword,
        address userAddress
    );
    event rentalCreated(
        uint256 rentalId,
        string name,
        string description,
        string[] imageURLs,
        uint256 pricePerNight,
        string contact,
        string rentalAddress,
        uint256 maxGuests,
        string city,
        string country,
        address owner
    );
    event rentalBooked(uint256 noOfGuests, uint256 startDate, uint256 endDate);

    //structs
    struct userDetails {
        string name;
        string dateOfBirth;
        string country;
        bytes32 hashedPassword;
        address userAddress;
    }

    struct rentalDetails {
        uint256 rentalId;
        string name;
        string description;
        string[] imageURLs;
        uint256 pricePerNight; //in eth
        string contact; //can be email or phone number
        string rentalAddress;
        uint256 maxGuests;
        string city;
        string country;
        address payable owner;
        bool isbooked;
    }

    struct bookedRentalDetails {
        uint256 noOfGuests;
        uint256 startDate;
        uint256 endDate;
    }

    //mappings
    mapping(uint256 => rentalDetails) id_to_rentalDetails;

    //errors
    error dairbnb__rentalAlreadyBooked();
    error dairbnb__enterCorrectAmount();

    //arrays
    userDetails[] public users;
    rentalDetails[] public listedRentals;
    bookedRentalDetails[] public bookedRentalInfo;

    //functions

    //create a new user
    function createUser(
        string memory _name,
        string memory _dateOfBirth,
        string memory _country,
        string memory _password
    ) public {
        bytes32 hashedPassword = keccak256(abi.encodePacked(_password)); //hash encoding the password for user privacy

        users.push(
            userDetails(
                _name,
                _dateOfBirth,
                _country,
                hashedPassword,
                msg.sender
            )
        );
        emit userCreated(
            _name,
            _dateOfBirth,
            _country,
            hashedPassword,
            msg.sender
        );
    }

    //create a new rental property
    function createRental(
        uint256 _rentalId,
        string memory _name,
        string memory _description,
        string[] memory _imageURLs,
        uint256 _pricePerNight,
        string memory _contact,
        string memory _rentalAddress,
        uint256 _maxguests,
        string memory _city,
        string memory _country
    ) public {
        rentalDetails memory rental = rentalDetails(
            _rentalId,
            _name,
            _description,
            _imageURLs,
            _pricePerNight,
            _contact,
            _rentalAddress,
            _maxguests,
            _city,
            _country,
            payable(msg.sender),
            false
        );

        id_to_rentalDetails[_rentalId] = rental;

        emit rentalCreated(
            _rentalId,
            _name,
            _description,
            _imageURLs,
            _pricePerNight,
            _contact,
            _rentalAddress,
            _maxguests,
            _city,
            _country,
            msg.sender
        );
    }

    //book a rental
    function bookRental(
        uint256 _rentalId,
        uint256 _startDate,
        uint256 _endDate,
        uint256 noOfGuests
    ) public payable {
        if (listedRentals[_rentalId].isbooked == true) {
            revert dairbnb__rentalAlreadyBooked();
        }
        if (
            msg.value ==
            ((listedRentals[_rentalId].pricePerNight) * (_endDate - _startDate))
        ) {
            listedRentals[_rentalId].owner.transfer(msg.value);
            listedRentals[_rentalId].isbooked = true;
            bookedRentalInfo.push(
                bookedRentalDetails(noOfGuests, _startDate, _endDate)
            );
            emit rentalBooked(noOfGuests, _startDate, _endDate);
        } else {
            revert dairbnb__enterCorrectAmount();
        }
    }

    //getter functions
    function getRentalDetails(
        uint256 _rentalId
    ) public view returns (rentalDetails memory) {
        return id_to_rentalDetails[_rentalId];
    }
}
