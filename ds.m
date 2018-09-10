% % % num_of_agent=10;
% % % num_of_keyword=6;
% % % num_of_round=10000;
% % % click_through_rate=rand(num_of_keyword,1);
% % % [click_through_rate,ind]=sort(click_through_rate,'descend');

num_of_agent=4;
num_of_keyword=3;
num_of_round=10;
click_through_rate=rand(num_of_keyword,1);
click_through_rate(1)=1;
click_through_rate(2)=2/3;
click_through_rate(3)=1/3;

% % % valuation=50*rand(num_of_agent,1);
% % % given_price=valuation;

valuation=50*rand(num_of_agent,1);
given_price=valuation;

valuation(1)=130;
valuation(2)=120;
valuation(3)=110;
valuation(4)=100;

given_price(1)=121.2394;
given_price(2)=103.3331;
given_price(3)=105
given_price(4)=100;

gamma=zeros(num_of_agent,1);
gamma(1)=1/2;
gamma(4)=0;
for i=2:3
    gamma(i)=click_through_rate(i)/click_through_rate(i-1);
end
nash=zeros(num_of_agent,1);
nash(4)=valuation(4);
for i=-3:-1
    j=-i;
    nash(j)=(gamma(j))*nash(j+1)+(1-gamma(j))*valuation(j);
end

[allocated_player,allocated_keyword,paid_price,ind]=GSP(click_through_rate,given_price);
utility=calc_utility(valuation,paid_price,click_through_rate,allocated_keyword);
allocated_keyword

for i=1:num_of_round
    known_price=given_price;
    given_price
    for j=1:num_of_agent
        given_price(j)=greedy_BB_new(j, click_through_rate, valuation(j), allocated_keyword, ind ,known_price);
    end
    figure(1);
    plot(nash(1),nash(2),'go','Markersize',5); hold on;
    plot(nash(3),nash(4),'yo','Markersize',5);
    plot(given_price(1),given_price(2),'ro','Markersize',5);
    plot(given_price(3),given_price(4),'bo','Markersize',5);
    hold off;
    axis([90 160 90 160]);
    pause(1);
    [allocated_player,allocated_keyword,paid_price,ind]=GSP(click_through_rate,given_price);
    utility=calc_utility(valuation,paid_price,click_through_rate,allocated_keyword);
end
