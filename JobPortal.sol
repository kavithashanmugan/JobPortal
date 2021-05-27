pragma solidity ^0.8.0;

/**
 * @title Storage
 * @dev Store & retreive value in a variable
 */
contract JobPortal {
    
    // enum JobStatus{
    //     posted,
    //     accepted,
    //     rejected,
    //     completed
    // }

    // struct Employee{
    //     uint256 employeeId;
    //     uint256 wallet;
        
    // }
    // struct Employer{
    //     uint256 employerId = 1234;
    //     uint256 wallet = 1000000;
    // }
    
    struct JobDetails{
        uint256 jobId;
        uint256 userId;
        string  jobTitle;
        string jobDescription;
        uint256 jobStartDate;
        uint256 jobEndDate;
        uint256 jobHours;
        uint256 payPerHour;
        string  status;
        uint256  employeeId;
        
        
    }
    
    struct account{
        uint256 userId;
        uint256 wallet;
    }
    
     uint256[] userArray;
     uint256[] jobArray;
     
     
//     modifier ifJobCompleted () {
//      require(Job[jobId].status == keccak256("completed"));
//   _;
//         }

    mapping(uint256 => JobDetails )Job;
    mapping(uint256 => account)accountDetails;
    
    function registerUser(uint256 userId,uint256 wallet) public {
        accountDetails[userId].userId = userId;
        accountDetails[userId].wallet = wallet;
        userArray.push(userId);

    }
    
    function postJob(
        uint256 userId,
        uint256 jobId,
        string memory jobTitle,
        string memory jobDescription,
        uint256 jobStartDate,
        uint256 jobEndDate,
        uint256 jobHours,
        uint256 payPerHour)
        public
        {
            Job[jobId].jobId = jobId;
            Job[jobId].userId = userId;
            Job[jobId].jobTitle = jobTitle;
            Job[jobId].jobDescription = jobDescription;
            Job[jobId].jobStartDate = jobStartDate;
            Job[jobId].jobEndDate = jobEndDate;
            Job[jobId].jobHours = jobHours;
            Job[jobId].payPerHour = payPerHour;
            Job[jobId].status = "posted";
            jobArray.push(jobId);
        }
        
    function viewWalletBalance(uint256 userId) public view returns(uint256 balance){
        return accountDetails[userId].wallet;
    }
    function viewJobDetails(uint256 jobId)public view returns(
        uint256 userId,
        string memory jobTitle,
        string memory jobDescription,
        uint256 jobStartDate,
        uint256 jobEndDate,
        uint256 jobHours,
        uint256 payPerHour,
        string memory JobStatus){
            
        userId = Job[jobId].userId;
        jobTitle = Job[jobId].jobTitle;
        jobDescription = Job[jobId].jobDescription;
        jobStartDate = Job[jobId].jobStartDate;
        jobEndDate = Job[jobId].jobEndDate;
        jobHours = Job[jobId].jobHours;
        payPerHour = Job[jobId].payPerHour;
        JobStatus = Job[jobId].status;
            
        
    }
        
    function completeJob(uint256 jobId)public{
        Job[jobId].status = "completed";
    }
    
    function acceptJob(uint256 jobId,uint256 employeeId)public{
        Job[jobId].employeeId = employeeId;
        Job[jobId].status = "accepted";
    }
    function checkJobStatus(uint256 jobId)public view returns(string memory status){
        return Job[jobId].status;
    }
    
    function payEmployee(uint256 jobId,uint256 employeeId,uint256 employerId) public {
      
        uint256 amountToBePaid = Job[jobId].jobHours * Job[jobId].payPerHour;
          require(accountDetails[employerId].wallet > amountToBePaid, "wallet balance insufficient");
        accountDetails[employerId].wallet -= amountToBePaid;
        accountDetails[employeeId].wallet += amountToBePaid;
        amountToBePaid=0;
        Job[jobId].status = "closed";
        
    }
    
    function viewUserList() public view returns(uint256[] memory userList){
        return userArray;
    }
    
     function viewJobList() public view returns(uint256[] memory jobList){
        return jobArray;
    }
}
