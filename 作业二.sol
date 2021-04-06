pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract PersonDID {
    struct Person {
        uint8 id;
        uint8 age;
        string name;
        string introduce;
        // string info;
    }
    
    event AddPerson(uint8 id, uint8 age, string name,string introduce, uint timestamp);
    event Experience(string experience,uint timestamp);
    
    
    Person admin;
    Person[] persons;
    mapping(address => Person) public PersonInfo;
    mapping(address=> bool) public isPersonExsist;
    
    constructor (address ip, uint8 id, string memory name,string memory introduce, uint8 age) public {
        admin = Person(id, age, name,introduce);
        Person memory p = Person(id, age, name,introduce);
        persons.push(p);
        PersonInfo[msg.sender] = p;
        isPersonExsist[msg.sender] = true;
    }
    
    function getNumberOfPersons() view public returns (uint256) {
        return persons.length;
    }
    
    function experience(uint8 id, uint8 age, string memory name,string memory introduce) public returns (bool) {
        require(!((id == 0) || age == 0), "persons info can not be empty!!");
        require(!isPersonExsist[msg.sender], "person can not exsist !!");
        Person memory person = Person(id, age, name,introduce);
        persons.push(person);
        PersonInfo[msg.sender] = Person(id, age, name,introduce);
        isPersonExsist[msg.sender] = true;
        emit AddPerson(id, age, name,introduce, now);
    }
    function addPerson(uint8 id, uint8 age, string memory name,string memory introduce) public returns (bool) {
        require(!((id == 0) || age == 0), "persons info can not be empty!!");
        require(!isPersonExsist[msg.sender], "person can not exsist !!");
        Person memory person = Person(id, age, name,introduce);
        persons.push(person);
        PersonInfo[msg.sender] = Person(id, age, name,introduce);
        isPersonExsist[msg.sender] = true;
        emit AddPerson(id, age, name,introduce, now);
    }
    
    function setPersonAgeSto(address ip, uint8 age) public {
        Person storage p = PersonInfo[ip];
        p.age = age;
    }
    
    function setPersonAgeMem(address ip, uint8 age) public {
        Person memory p = PersonInfo[ip];
        p.age = age;
    }
    
    function getPersonAge(address ip) public view returns (uint8) {
        return PersonInfo[ip].age;
    }
    
}