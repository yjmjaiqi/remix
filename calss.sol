pragma solidity ^0.6.0;

contract UserManager {
    address payable public owner;
    
    struct Person {
        uint8 id;
        uint8 age;
        string name;
        // string info;
    }
    
    mapping(uint8 => string) accounts;    //id -> passwd
    mapping(uint8 => address) ips;       //IP address
    
    event Login(uint8 id, uint time);
    event Register(uint8 id,uint time);
    event SetPassword(string passwd);
    
    constructor () public {
        owner = msg.sender;
    }
    
    function login(uint8 id, string memory passwd) public returns(bool) {
        
        require(ips[id] == msg.sender);
     if (keccak256(abi.encodePacked(accounts[id])) ==keccak256(abi.encodePacked(passwd))) { //debug修复
            emit Login(id, now);
            return true; 
        }
        return false;
    }
    
    function getIP(uint8 id) public view returns (address) {
        require(ips[id] != address(0));
        return ips[id];
    }
    
    function register(uint8 id, string memory passwd) public returns (bool) {//登录功能
         require(ips[id] == msg.sender);
         require(ips[id] != address(0));
        if (keccak256(abi.encodePacked(accounts[id])) ==keccak256(abi.encodePacked(passwd))) {
            emit Login(id, now);
            return true; 
        }
        return false;
    }
    
    function setPassword(uint8 id,string memory passwd) public returns (bool) {//设置密码
         require(ips[id] == msg.sender);
        if (keccak256(abi.encodePacked(accounts[id])) ==keccak256(abi.encodePacked(passwd))) {
            emit Login(id, now);
            return true;
        }
    }
  }