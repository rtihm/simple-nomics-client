# Simple Nomics Client

### Notes

* No external libraries outside ruby stdlib
* Partial specs because of time restriction
* API key from PDF did not work.
  
### Tasks

#### 1. Retrieve a list of cryptocurrencies given set of tickers.
> I want to get the full payload of those cryptocurrencies

`bin/nomics -k YOU_API_KEY -t ETH,BTC,LTC`

#### 2. Retrieve a (list) specific crypto currency and specific values based on the ticker and any other dynamic params

`bin/nomics -k YOU_API_KEY -f circulating_supply,max_supply,name,symbol,price -t BTC,LTC`

#### 3. Retrieve a specific cryptocurrency to specific fiat. Ie: BTC in ZAR or ETH in USD

`bin/nomics -k YOU_API_KEY --price-only -c EUR -t ETH,LTC,BTC`

OR

`bin/nomics -k YOU_API_KEY -t ETH,BTC,LTC -c EUR`


#### 4. Calculate the price of one cryptocurrency from another, in relation to their dollar value

`bin/nomics -k YOU_API_KEY --calc-price-from BTC --calc-price-to ETH`
