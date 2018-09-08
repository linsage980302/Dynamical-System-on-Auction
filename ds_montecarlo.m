num_of_agent=4;
num_of_keyword=3;
num_of_round=100;
click_through_rate=rand(num_of_keyword,1);

click_through_rate(1)=1;
click_through_rate(2)=2/3;
click_through_rate(3)=1/3;

valuation=50*rand(num_of_agent,1);
given_price=zeros(num_of_agent,1);

valuation(1)=161;
valuation(2)=160;
valuation(3)=159;
valuation(4)=150;

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

unstable=rand(4,1);
unstable(1)=130.5;
unstable(2)=130;
unstable(3)=129.5;
unstable(4)=100;

for times=1:100000
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
        if normest(given_price-nash)<0.0001
            plot(a,b,'ro','MarkerFaceColor','r');
            axis([90 165 90 165]);
            hold on;
            break;
        end
% % %         if normest(given_price-unstable)<0.0001
% % %             plot(a,b,'bo','MarkerFaceColor','b');
% % %             axis([85 165 85 165]);
% % %             hold on;
% % %             break;
% % %         end
        if i==99
            plot(a,b,'go','MarkerFaceColor','g');
            axis([85 165 85 165]);
            hold on;
            break;
        end
    end
    if mod(times,1000)==0
        times
    end
end