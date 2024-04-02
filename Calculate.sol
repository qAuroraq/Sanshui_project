pragma solidity ^0.6.10;

contract Calculate{
    uint256 total_people = 28760;
    uint256 machine_num = 2870000000000;
    uint256[10] frequency;
    uint256[6] demand_per_day;
    uint256[] people;
    uint256[20] service_times;
    uint256[20] service_time_internal;
    uint256[20] one_machine_time;
    uint256[20] real_service_times;
    uint256[20] real_service_time;
    uint256[20] can_close_machine;
    uint256[5] water_usage;
    uint256[5] electricity_usage;
    uint256[5] sevice_type_count;
    uint256 Total_per_day;
    uint256 total_water_costs = 0;
    uint256 total_electricity_costs = 0;
    uint256 sum_income = 0;
    constructor() public{
       frequency[0] = 0;
       frequency[1] = 2450000000;
       frequency[2] = 2300000000;
       frequency[3] = 4200000000;
       frequency[4] = 650000000;
       frequency[5] = 400000000;
       cal();
       
       demand_per_day[0] = 10000000000;
       demand_per_day[1] = 25000000000;
       demand_per_day[2] = 45000000000;
       demand_per_day[3] = 70000000000;
       demand_per_day[4] = 140000000000;
       
       water_usage[0] = 1300000000;
       water_usage[1] = 800000000;
       water_usage[2] = 1300000000;
       water_usage[3] = 192000000;
       water_usage[4] = 1300000000;
       
       electricity_usage[0] = 1500000000;
       electricity_usage[1] = 1200000000;
       electricity_usage[2] = 1800000000;
       electricity_usage[3] = 288000000;
       electricity_usage[4] = 1800000000;
       Service_perday();
       Service_times();
       get_real_service();
       machine_availability();
       Calculate_fee();
    }
    
    function div(uint256 _a, uint256 _b) public pure returns(uint256){
        return _a / _b;
    }
    
    function cal() private{
        for(uint256 i = 0; i < 6; i ++ ){
            uint256 x = frequency[i] * total_people;
            people.push(x);
        }
    }
    
    function get() public returns(uint256[] memory){
        uint256[] memory person = new uint256[](6);
        for(uint256 i = 0; i < 6; i ++ ){
            person[i] = people[i];
        }
        return person;
    }

    function Service_perday() public returns(uint256 sum){
        sum += div(people[0], demand_per_day[0]);
        sum += div(people[1], demand_per_day[1]);
        sum += div(people[2], demand_per_day[2]);
        sum += div(people[3], demand_per_day[3]);
        sum += div(people[4], demand_per_day[4]);
        Total_per_day = sum;
        return sum;
    }
    
    function Service_times() public{
        uint256[20] memory proportion;
        proportion[0] = 151520000;
        proportion[1] = 234160000;
        proportion[2] = 413220000;
        proportion[3] = 564740000;
        proportion[4] = 454550000;
        proportion[5] = 619830000;
        proportion[6] = 647380000;
        proportion[7] = 674930000;
        proportion[8] = 523420000;
        proportion[9] = 592290000;
        proportion[10] = 564740000;
        proportion[11] = 495870000;
        proportion[12] = 950410000;
        proportion[13] = 1129480000;
        proportion[14] = 1212120000;
        proportion[15] = 688710000;
        proportion[16] = 82640000;
        for(uint256 i = 0; i < 17; i ++ ){
             uint256 x = Total_per_day * proportion[i];
             service_times[i] = x;
             service_time_internal[i] = x * 443494800000;
             one_machine_time[i] = div(service_time_internal[i], machine_num);
        }
    }
    
    function show() public returns(uint256[] memory){
        uint256[] memory show = new uint256[](17);
        for(uint256 i = 0; i < 17; i ++ ){
            show[i] = one_machine_time[i];
        }
        return show;
    }
    
    function get_real_service() public{
        uint256 max_service_times = 13528910000;
         for(uint256 i = 0; i < 17; i ++ ){
             if(one_machine_time[i] > 60000000000000){
                 real_service_times[i] = max_service_times;
                 real_service_time[i] = 60000000000000;
             }
             else{
                 real_service_times[i] = service_times[i];
                 real_service_time[i] = one_machine_time[i];
             }
         }
    }
    
    function machine_availability() public{
        uint256 max_service_time = 60 * machine_num;
        for(uint256 i = 0; i < 17; i ++ ){
            uint256 value = max_service_time - service_time_internal[i];
            if(value > 0){
                can_close_machine[i] = div(value, 60);
            }
            else{
                can_close_machine[i] = 0;
            }
        }
    }
    
    function Save_Money() public returns(uint256,uint256){
        uint256 total_machine_off = 0;
        for(uint256 i = 0; i < 17; i ++ ){
            total_machine_off += can_close_machine[i];
        }
        
        uint256 enery_saving = total_machine_off * 7000000 * 14;
        
        uint256 carbon_compensation = enery_saving * 400000000;
        return (enery_saving,carbon_compensation);
    }
    
    function Calculate_fee() public returns(uint256,uint256,uint256){
        sevice_type_count[0] = Total_per_day * 6470000000;
        sevice_type_count[1] = Total_per_day * 991000000;
        sevice_type_count[2] = Total_per_day *2140000000;
        sevice_type_count[3] = Total_per_day * 242000000;
        sevice_type_count[4] = Total_per_day * 157000000;
        sum_income += sevice_type_count[0] * 3;
        sum_income += sevice_type_count[1] * 2;
        sum_income += sevice_type_count[2] * 4;
        sum_income += sevice_type_count[4] * 5;
        
        uint256 water_price = 50000000000;
        
        uint256 electricity_price = 5100000000;
        
        uint256 water_usage_sum;
        uint256 electricity_usage_sum;
        for(uint256 i = 0; i < 5; i ++ ){
            water_usage_sum += sevice_type_count[i] * water_usage[i];
            electricity_usage_sum += sevice_type_count[i] * electricity_usage[i];
        }
        total_water_costs = water_usage_sum * water_price;
        total_electricity_costs = electricity_usage_sum * electricity_price;
        return (sum_income,total_water_costs,total_electricity_costs);
    }
    
    function calculate_monthly_financials(uint256 nums) public returns(uint256){
        //每台洗衣机的价格
        uint256 machine_price = 3000;
        //年折旧率
        uint256 annual_depreciation_rate = 2000000000;
        //每台洗衣机月折旧
        uint256 monthly_depreciation = div(machine_price * annual_depreciation_rate,12);
        //每名维修工人月工资
        uint256 repairman_salary = 3000;
        //每名管理人员月工资
        uint256 manager_salary = 4000;
        //雇佣维修工人数
        uint256 num_repairmen = 2;
        //雇佣管理人员数
        uint256 num_managers = 2;
        //每月总体洗衣机故障率
        uint256 machine_failure_rate = 500000000;
        //每台洗衣机月租金
        uint256 machine_rent = 300;
        //营业税率
        uint256 business_tax_rate = 500000000;
        //减按税率
        uint256 reduced_tax_rate = 2500000000;
        //每台洗衣机的平台费用
        uint256 platform_fee = 50;
        //所得税率
        uint256 income_tax_rate = 2000000000;

        //计算每月各项费用
        uint256 monthly_depreciation_cost = machine_num * monthly_depreciation;
        uint256 repairman_salary_cost = num_repairmen * repairman_salary;
        uint256 manager_salary_cost = num_managers * manager_salary;
        return 50000;
        uint256 platform_fee_cost = platform_fee * machine_num;
        uint256 machine_rent_cost = machine_rent * machine_num;
        uint256 repair_cost = 150 * machine_failure_rate * machine_num;

        uint256 utility_cost = (total_water_costs + total_electricity_costs) * 30;
        

        // 计算总收入
        uint256 total_income = sum_income * 30 * 7143000000;

        //计算营业税
        uint256 business_tax = business_tax_rate * total_income;

        //计算总成本
        uint256 total_cost = monthly_depreciation_cost + repairman_salary_cost + manager_salary_cost + platform_fee_cost +
            machine_rent_cost + repair_cost + utility_cost + business_tax;
        

        // 计算利润
        uint256 profit = total_income - total_cost;

        //计算净利润
        uint256 net_profit = profit - profit * (10000000000 - reduced_tax_rate) * income_tax_rate;
        return income_tax_rate;
    }
    
    function calculate_marginal_profit(uint256 num, uint256 new_num) public returns(uint256){
        uint256 original_net_profit = calculate_monthly_financials(num);
        uint256 new_net_profit = calculate_monthly_financials(num + new_num);
        
        uint256 marginal_profit = new_net_profit - original_net_profit;
        return marginal_profit;
    }
}