function[allocated_player,allocated_keyword,paid_price, ind]=GSP(click_through_rate,given_price)
tempsize=size(click_through_rate);
num_of_keyword=tempsize(1);
tempsize=size(given_price);
num_of_agent=tempsize(1);
paid_price=zeros(num_of_agent,1);
allocated_keyword=zeros(num_of_agent,1);

[temp_price ,ind]=sort(given_price,'descend');
allocated_player=ind(1:num_of_keyword);
for i=1:num_of_keyword
    allocated_keyword(allocated_player(i))=i;
    paid_price(allocated_player(i))=temp_price(i+1);
end
end