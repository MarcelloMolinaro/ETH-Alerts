#set your own working directory! (#This is Windows)
setwd("C:/Users/marcello/Web-Scraping-Twilio")

#Load files:  1) contains twilio credentials (replace with your own!) 
#             2) contains the previous price

load("save_credentials.RData")
if(!exists("previous_price")) {
  load("save_price.RData")
}

#Credit goes to:  https://seankross.com/2017/03/07/Send-a-Text-from-R-with-Twilio.html
#The texting section: Using Twilio
require(twilio)

twilio_send <- function (message) {
  # First you need to set up your accound SID and token as environmental variables
  Sys.setenv(TWILIO_SID = TWILIO_SID)
  Sys.setenv(TWILIO_TOKEN = TWILIO_TOKEN)
  
  # Store incoming and outgoing numbers
  #my_phone_number <- ??? From credentials
  #twilios_phone_number <- ??? From credentials
  
  # Send message
  tw_send_message(from = twilios_phone_number, to = my_phone_number, 
                  body = message)
}

#The web scraping section, using Rvest and xml2
require(xml2)
require(rvest)

url <- "https://cointelegraph.com/ethereum-price-index"

price <- read_html(url) %>%
        html_node(".price-value") %>%
        html_text(trim = TRUE)

#remove $ sign/only keep numbers and - or (.)
# I guess I could have gsub'd "$". Oh well.. I like the regex practice
price <- gsub("[^0-9.-]", "", price) %>%
          as.numeric()

#Combining all the sections
#Depending on price change bucket, chose to send differnet message, or no message at all
#Highly modify-able
if (price  > 360 && previous_price <= 360) {
    twilio_send("ETH Price over $360: Sell Some?")
} else if (price > 400 && previous_price <= 400) { 
    twilio_send("ETH Price over $400: Sell more?")
} else if (price > 600 && previous_price <= 600) { 
  twilio_send("ETH Price over $600: Sell a lot? When will bubble pop?")
} else if (price < 300 &&  previous_price >= 300) {
    twilio_send("ETH Price below $300: Bubble over")
} else if (price < 150 && prevprevious_price >= 150) {
    twilio_send("ETH Price less than $150: BUY?!")
}
#Deliver Price statistics
paste("ETH today: ", price)
paste("ETH yesterday: ", previous_price)

#Saves Today's price to reference for tomorrow's price change
previous_price <- price
save(previous_price, file = "save_price.RData")

#When running your own version you will need to define these 4 variables and then save them
#TWILIO_SID <- "??????????????????"
#TWILIO_TOKEN <- "??????????????????"
#my_phone_number <- "???????????"
#twilios_phone_number <- "???????????" 
#
#save(TWILIO_SID,
#     TWILIO_TOKEN,
#     my_phone_number,
#     twilios_phone_number, 
#     file = "save_credentials.RData")


