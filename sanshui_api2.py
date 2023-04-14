
import os



XUPERCHAIN_DIR = 'xuperchain/'
OUTPUT_DIR = 'xuperchain/output'

sample_dic = {#默认用户信息
    'name':'testuser',
    'amount':100,
    'address':'None',
    'dir':'None'
}

def write_terminal(input):
    return os.popen(input).read()

def goto_place():
    os.chdir('xuperchain/output')

def goback_place():
    os.chdir('../../')

class Xuper_account():
    def __init__(self,init_dic = sample_dic):
        self.name = init_dic['name']
        self.dir = 'data/'+self.name+'/'
        self.amount  = init_dic['amount']
        self.address = 'Not yet update'
        self.update_init()
    
    def update_init(self):
        #goto_place()
        para = [OUTPUT_DIR,"bin/xchain-cli account newkeys --output",OUTPUT_DIR,"data/" + self.name]
        input = ' '.join(para)
        #传参到区块链
        

        output = write_terminal(input)
        print(output)
        os.chdir(os.path.join(OUTPUT_DIR,'data',self.name))
        with open('address','r') as f:
            address = f.read()
        self.address = address 
        print("account " + self.name + " address is "+ self.address)
        os.chdir('../../../../')
        #self.address = 
        #goback_place()
        return output
        
        
    def transfer(self,target_address,amount):
        #goto_place()
        #input = "bin/xchain-cli transfer --to czojZcZ6cHSiDVJ4jFoZMB1PjKnfUiuFQ --amount 10 --keys data/keys/ -H 127.0.0.1:37101"
        #self_dir = os.path.join('data',self.name)
        para = [OUTPUT_DIR,"bin/xchain-cli transfer --to", target_address, '--amount', str(amount) ,"--keys ",self.dir, "-H 127.0.0.1:37101"]
        input = ' '.join(para)
        #传参到区块链
        output = write_terminal(input)
        #goback_place()
        return output
    
    def update(self):
        #goto_place()
        #查询区块链
        #bin/xchain-cli account balance --keys data/bob -H 127.0.0.1:37101
        para = [OUTPUT_DIR,"bin/xchain-cli account balance --keys",self.dir,"-H 127.0.0.1:37101"]
        input = ' '.join(para)
        output = write_terminal(input)
        self.amount = output
        #goback_place()
        return output

    def check_account(self):
        self.update()
        return self.amount 

def start_blockchain():

    goto_place()
    #默认成功
    satus = write_terminal("bin/xchain-cli status -H 127.0.0.1:37101")
    goback_place()
    return satus

def main():
    du_dic = {#默认用户信息
    'name':'du',
    'amount':100,
    'address':'None',
    'dir':'None'
    }
    gu_dic = {#默认用户信息
    'name':'gu',
    'amount':100,
    'address':'None',
    'dir':'None'
    }
    print(start_blockchain())
    du = Xuper_account(du_dic)
    gu = Xuper_account(gu_dic)
    du.transfer(gu.address,10)
    gu.check_account
    print(gu.amount)



if __name__ == '__main__':

    main()
