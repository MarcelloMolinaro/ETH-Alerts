# ETH Alerts
A program that scrapes Ethereum price website and sends a text alert depending on how the price has changed since the previous time the program ran.

## Who is this for?
Anyone who wants to manage and customize their Ethereum notifications.

## Why is this different?
There are more complex, sophisticated tools for this process. For example:
- https://cryptocurrencyalerting.com/
- https://cryptoalertzz.com
- https://coinwink.com/eth
- www.teamfox.co/mammon 

However, none of these allow for you to host and run your own notification. This allows for all of the customization you want to build. Your flexibility is endless. If you want someone else to see the notifications you set, or simply manage them, go with the other options. If you want to own the process and customize it, use this open source program!

## How do I use it?
### This requires that you have:
1. A phone number
2. A Twilio account
    * You can create a Twilio account for free and you will receive $15 in trial $$$ to develop and test with. Each text is ~1 cent
    * https://www.twilio.com/try-twilio
  
### Code you will need to modify:
1) Your working directory `setwd("C:/Users/...")`
2) Your credentials   
`TWILIO_SID <- ?,  
TWILIO_TOKEN <- ?,  
my_phone_number <- ?,  
twilios_phone_number <- ? `  

### Run the Program
1) Clone the repository
2) Open `ETH Price Alerts- For Public.R`
3) Get your Twilio credentials
4) Save them to your `save_credentials.RData` file
    - Instructions in the main file
5) Run the Program
    - You will see "Previous Price" and "Today's Price" printed, and if the price change falls into the defined logic, you will recieve a text notification
6) Customize your program!
    - Connect this to other currencies
    - Modify the logic for the price changes
    * Send notifcations to others
    - etc.

## How does it work?
- Using packages Rvest and xml2, the program scrapes data from https://cointelegraph.com/ethereum-price-index. 
- Using a saved file, it compares today's price vs the previous price. 
- If the price change falls into a predetermined logic (customizable), the program uses the Twilio API via the R twilio package, to send a text message to the defined phone number

Let me know if you have any questions!
