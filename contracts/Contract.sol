pragma solidity ^0.8.0;

contract MedicalRecords {
    // Define a struct to hold patient information
    struct Document {
        string name;
        string document;
    }
    struct Patient {
        string height;
        string weight;
        string blood_group;
        string age;
        string gender;
        string[] documents;
    }

    // Define a struct to hold doctor information
    struct Doctor {
        string specialty;
        address[] patients;
    }


    // Define mappings to store patients and doctors
    mapping(address => Patient) public patients;
    mapping(address => Doctor) public doctors;
    mapping(address => Document[]) public patientDocuments;

    // Define a function for patients to add their basic information
    function addPatientInfo(string memory _height, string memory _weight, string memory _blood_group, string memory _age, string memory _gender) public {
        patients[msg.sender] = Patient(_height, _blood_group, _weight, _age, _gender, new string[](0));
    }

    // Define a function for doctors to add patient documents
    function addPatientDocument(address _patientAddress, string memory _document) public {
        patients[_patientAddress].documents.push(_document);
    }

    // Define a function for patients to get their own information and documents
   function getPatientInfo(address _patientAddress) public view returns (string memory, string memory, string memory, string memory, string memory) {
    Patient memory patient = patients[_patientAddress];
    return (patient.height, patient.weight, patient.blood_group, patient.age, patient.gender);
}


    function getPatientDocuments(address _patientAddress) public view returns (Document[]  memory) {
  return patientDocuments[_patientAddress];
      }

    

    // Define a function to check if an address is mapped to a doctor or patient
    function isDoctorOrPatient(address _address) public view returns (string memory) {
        if (bytes(patients[_address].blood_group).length > 0) {
            return "Patient";
        } else if (bytes(doctors[_address].specialty).length > 0) {
            return "Doctor";
        } else {
            return "Neither";
        }
    }

    // Define a function to map an address to a doctor
    function addDoctor(string memory _specialty) public {
        doctors[msg.sender] = Doctor(_specialty, new address[](0));
    }

    // Define a function to set an address to a patient
    function addPatient(address _address, string memory _height, string memory _weight, string memory _blood_group, string memory _age, string memory _gender) public {
        patients[_address] = Patient(_height,_weight, _blood_group, _age, _gender, new string[](0));
    }

    function addPatientDocument(address _patientAddress, string memory _name, string memory _document) public {
        // Create a new Document struct with the provided name and document
        Document memory newDocument = Document(_name, _document);
        // Add the new document to the patient's document array
        patientDocuments[_patientAddress].push(newDocument);


    }
}