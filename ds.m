num_of_agent=10;
num_of_keyword=6;
num_of_round=10000;
click_through_rate=rand(num_of_keyword,1);
[click_through_rate,ind]=sort(click_through_rate,'descend');

valuation=50*rand(num_of_agent,1);
given_price=valuation;

[allocated_player,allocated_keyword,paid_price,ind]=GSP(click_through_rate,given_price);
utility=calc_utility(valuation,paid_price,click_through_rate,allocated_keyword);


for i=1:num_of_round
    known_price=given_price;
    for j=1:num_of_agent
        given_price(j)=greedy_BB(j, click_through_rate, valuation(j), allocated_keyword, ind ,known_price);
    end
    given_price
    [allocated_player,allocated_keyword,paid_price,ind]=GSP(click_through_rate,given_price);
    utility=calc_utility(valuation,paid_price,click_through_rate,allocated_keyword);
end