num_of_agent=4;
num_of_keyword=3;
num_of_round=20;
click_through_rate=rand(num_of_keyword,1);

click_through_rate(1)=1;
click_through_rate(2)=2/3;
click_through_rate(3)=1/3;

valuation=50*rand(num_of_agent,1);
given_price=zeros(num_of_agent,1);

valuation(1)=100;
valuation(2)=110;
valuation(3)=120;
valuation(4)=130;

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
nash
nash_tmp = sort(nash, 'descend');

unstable=rand(4,1);
unstable(1)=130.5;
unstable(2)=130;
unstable(3)=129.5;
unstable(4)=100;

for times=1:50000
    a=90+71*rand();
    b=90+71*rand();
    given_price(1)=a;
    given_price(2)=b;
    given_price(3)=nash(3);
    given_price(4)=nash(4);

    [allocated_player,allocated_keyword,paid_price,ind]=GSP(click_through_rate,given_price);
    utility=calc_utility(valuation,paid_price,click_through_rate,allocated_keyword);
    tag=1;
    for i=1:num_of_round
        known_price=given_price;
        for j=1:num_of_agent
            given_price(j)=greedy_BB_new(j, click_through_rate, valuation(j), allocated_keyword, ind ,known_price);
        end
        [allocated_player,allocated_keyword,paid_price,ind]=GSP(click_through_rate,given_price);
        utility=calc_utility(valuation,paid_price,click_through_rate,allocated_keyword);
        test_nash=sort(given_price, 'descend');
        if normest(test_nash-nash_tmp)<0.0001
            plot(a,b,'r.','MarkerFaceColor','r');
            axis([85 165 85 165]);
            hold on;
            break;
        end
% % %         if normest(test_nash-unstable)<0.0001
% % %             plot(a,b,'bo','MarkerFaceColor','b');
% % %             axis([85 165 85 165]);
% % %             hold on;
% % %             break;
% % %         end
        if i==num_of_round
            plot(a,b,'g.','MarkerFaceColor','g');
            axis([85 165 85 165]);
            hold on;
            break;
        end
    end
    if mod(times,1000)==0
        times
    end
end
