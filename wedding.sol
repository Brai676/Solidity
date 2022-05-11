pragma solidity 0.6.0;

contract Marriage {
    // Marriage data variables
    address public owner;
    bytes32 public partner1;
    bytes32 public partner2;
    uint256 public marriageDate;
    bytes32 public marriageStatus;
    bytes public imageHash;
    bytes public marriageProofDoc;
    
    //Set Owner
    function newMarriage() public {
        owner = msg.sender;
    }
    modifier onlyowner() { 
        if (msg.sender == owner)
            _;
    }

    // Create initial marriage contract
    function createMarriage(bytes32 partner1Entry, bytes32 partner2Entry, uint256 marriageDateEntry, bytes32 statusEntry, bytes32 descriptionEntry) onlyowner public {
        partner1 = partner1Entry;
        partner2 = partner2Entry;
        marriageDate = marriageDateEntry;
        setStatus(statusEntry);
        bytes32 name = "Marriage Contract Creation";
        
        majorEventFunc(marriageDate, name, descriptionEntry);
    }
    
    function getOwner() public view returns (address _owner) {
        return owner;
    }
    
    // Set the marriage status if it changes
    function setStatus(bytes32 status) onlyowner public {
        marriageStatus = status;
        majorEventFunc(block.timestamp, "Changed Status", status);
    }
    
    // Set the IPFS hash of the image of the couple
    function setImage(bytes memory IPFSImageHash) onlyowner public {
        imageHash = IPFSImageHash;
        majorEventFunc(block.timestamp, "Entered Marriage Image", "Image is in IPFS");
    }
    
    // Upload documentation for proof of marrage like a marriage certificate
    function marriageProof(bytes memory IPFSProofHash) onlyowner public {
        marriageProofDoc = IPFSProofHash;
        majorEventFunc(block.timestamp, "Entered Marriage Proof", "Marriage proof in IPFS");
    }

    // Log major life events
    function majorEventFunc(uint256 eventTimeStamp, bytes32 name, bytes32 description) public {
        emit MajorEvent(block.timestamp, eventTimeStamp, name, description);
    }

    // Declare event structure
    event MajorEvent(uint256 logTimeStamp, uint256 eventTimeStamp, bytes32 indexed name, bytes32 indexed description);  
}