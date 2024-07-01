/*
████████ ██     ██  ██████  ███████  █████   ██████ ████████  ██████  ██████   █████  ██    ██ ████████ ██   ██ 
   ██    ██     ██ ██    ██ ██      ██   ██ ██         ██    ██    ██ ██   ██ ██   ██ ██    ██    ██    ██   ██ 
   ██    ██  █  ██ ██    ██ █████   ███████ ██         ██    ██    ██ ██████  ███████ ██    ██    ██    ███████ 
   ██    ██ ███ ██ ██    ██ ██      ██   ██ ██         ██    ██    ██ ██   ██ ██   ██ ██    ██    ██    ██   ██ 
   ██     ███ ███   ██████  ██      ██   ██  ██████    ██     ██████  ██   ██ ██   ██  ██████     ██    ██   ██ 
                                                                                                                                                                                                                              
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SafeMath.sol";

contract TwoFactorAuth {
    using SafeMath for uint256;

    struct User {
        string username;
        address publicKey;
        uint256 seed;
        uint256 lastOTP;
        uint256 lastOTPTime;
    }

    mapping(address => User) private users;
    uint256 private constant OTPValidity = 80 seconds;

    event UserRegistered(string username, address publicKey);
    event OTPGenerated(address publicKey, uint256 OTP);
    event UserAuthenticated(address publicKey);

    function registerUser(string memory _username, address _publicKey, uint256 _seed) public {
        User storage user = users[_publicKey];
        require(user.publicKey == address(0), "User already exists");

        user.username = _username;
        user.publicKey = _publicKey;
        user.seed = _seed;

        emit UserRegistered(_username, _publicKey);
    }

    function generateOTP(address _publicKey) public {
        User storage user = users[_publicKey];
        require(user.publicKey != address(0), "User does not exist");

        // uint256 OTP = (user.seed.add(block.timestamp)).mod(10000);
        uint256 OTP = (user.seed.add(block.timestamp)) % 10000;

        user.lastOTP = OTP;
        user.lastOTPTime = block.timestamp;

        emit OTPGenerated(_publicKey, OTP);
    }

    function authenticateUser(address _publicKey, uint256 _OTP) public {
        User storage user = users[_publicKey];
        require(user.publicKey != address(0), "User does not exist");
        require(user.lastOTP == _OTP, "Invalid OTP");
        require(block.timestamp <= user.lastOTPTime.add(OTPValidity), "OTP expired");

        user.lastOTP = 0;

        emit UserAuthenticated(_publicKey);
    }
}
