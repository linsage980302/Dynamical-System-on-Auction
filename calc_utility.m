function[utility]=calc_utility(valuation,paid_price,click_through_rate,allocated_keyword)
tempsize=size(paid_price);
num_of_agent=tempsize(1);
utility=zeros(num_of_agent,1);
for i=1:num_of_agent
    key=allocated_keyword(i);
    if(key~=0)
        utility(i)=click_through_rate(key)*(valuation(i)-paid_price(i));
    end
end
end