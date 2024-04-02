import sys
sys.path.append("python-sdk")
from client.bcosclient import BcosClient


client = BcosClient()
address = "0xb0be4c9faf529c2408bf2de959cfa56b965ed93c";
abi = [{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[],"name":"Calculate_Income","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"Save_Money","outputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"Service_perday","outputs":[{"internalType":"uint256","name":"sum","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"Service_times","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_a","type":"uint256"},{"internalType":"uint256","name":"_b","type":"uint256"}],"name":"div","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"pure","type":"function"},{"inputs":[],"name":"get","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"get_real_service","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"machine_availability","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"show","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"nonpayable","type":"function"}]
data = client.call(address,abi,"Calculate_Income")
print(float(data[0] / 10000000000))
# data = client.sendRawTransactionGetReceipt(address,abi,"set",["aa"])
#print(data)
#data = client.call(address,abi,"get")
#print(data)

client.finish()
