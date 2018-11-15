pragma solidity ^0.4.24;

///@title AltProof
///@author andersonassis83 - adeassis@htmlcoin.team

contract AltProof{
    
    struct Document{
        bool stored;
        uint blockNumber;
        uint blockTimestamp;
        address sender;
    }
    
    mapping(string => Document) internal documents;
    event DocumentEvent(uint blockNumber, string hash);

    ///@dev Adds a new record to the blockchain. To be used internally only.
	///@param hash An unique hash based on all Document attributes. Should be encrypted externally.
    function addDocument(string hash) internal {
        documents[hash].stored = true;
        documents[hash].blockNumber = block.number;
        documents[hash].blockTimestamp = block.timestamp;
        documents[hash].sender = msg.sender;
    }
    
    
    ///@dev The external access for the addDocument function.
    ///     Checks if that Document has already been added to the blockchain.
    ///     If not, it calls the addDocument function.
	///@param hash An unique hash based on all Document attributes. Should be encrypted externally.
    function newDocument(string hash) external returns(bool success){
        if(documents[hash].stored){
            success = false;
        } else {
            addDocument(hash);
            emit DocumentEvent(documents[hash].blockNumber, hash);
            success = true;
        }
    }
    
    ///@dev Displays Document data based on its unique hash.
    ///@param hash An unique hash based on all Document attributes. Should be encrypted externally.
    function getDocument(string hash) external view returns (bool stored, uint blockNumber, uint blockTimestamp, address sender){
        return (documents[hash].stored, documents[hash].blockNumber, documents[hash].blockTimestamp, documents[hash].sender);
    }
    
    ///@dev Throw if any coin is received
    function() public payable{
        revert();
    }
}
