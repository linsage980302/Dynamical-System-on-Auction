function[bid]=greedy_BB(num, click_through_rate, value, allocated_keyword, ind ,given_price)
%this is the algorithm under GSP
tempsize=size(click_through_rate);
num_of_keyword=tempsize(1);
tempsize=size(given_price);
num_of_agent=tempsize(1);

must_pay=zeros(num_of_keyword,1);
if(allocated_keyword(num)==0)
    for i=1:num_of_keyword
        must_pay(i)=given_price(ind(i));
    end
else
    for i=1:num_of_keyword
        if i<allocated_keyword(num)
            must_pay(i)=given_price(ind(i));
        else
            must_pay(i)=given_price(ind(i+1));
        end
    end
end
wanted=1;
for i=1:num_of_keyword
    if click_through_rate(i)*(value-must_pay(i))>click_through_rate(wanted)*(value-must_pay(wanted))
        wanted=i;
    end
end
if wanted==1
    bid=(value+must_pay(1))/2;
else
    bid=value-click_through_rate(wanted)/click_through_rate(wanted-1)*(value-must_pay(wanted));
end
end