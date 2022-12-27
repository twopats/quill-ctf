### Hacking Road Closed

Requirements:

1) become owner 
2) set hacked = true

Main Vulnerabilities:

1) All critical functions are public. You can just call manually from your EOW as so: addToWhitelist(YOUR_ADDR) && changeOwner(YOUR_ADDR) && pwn("YOUR_ADDR"); 

2) If you'd like to exploit using a contract, The target contract relies on isContract() check to secure critical functions. It does so via assembly via extcodesize, passing in the address of the caller. However, we can bypass this check by running our exploitation code in the constructor of our attacking contract. The codesize is when the constructor function gets run. That's because the constructor (contract creation code) only returns the runtime code at the *end* of its execution. 


```Solidity
function isContract(address addr) public view returns (bool) {
    uint size;
    assembly {
        size := extcodesize(addr)
        }
    return size > 0;
}
```

reference: you can find this info in the footnote at the bottom of page 11 of the ethereum yellow paper


Walkthrough: 

1) Deploy a contract that calls the target RoadClosed contract and invoke its addToWhitelist(YOUR_ADDR) | alternatively you can just call this function using your wallet with no need to bypass isContract at all

2) Once whitelisted you can make yourself the owner with changeOwner(YOUR_ADDR)

3) Once you are the owner, go ahead and call pwn(YOUR_ADDR) to change the value of 'hacked' to true;



