import "commonReactions/all.dsl";

context 
{
    // declare input variables phone and name  - these variables are passed at the outset of the conversation. In this case, the phone number and customer’s name 
    input phone: string;

    // declare storage variables 
    output first_name: string = "";
    output last_name: string = "";
    output device_num: string = "";
    output zip_code: string = "";

}

// declaring external functions


start node root 
{
    do 
    {
        #connectSafe($phone);
        #waitForSpeech(1000);
        #sayText("Hello, thank you for contacting Xfinity Support. My name is Dasha. Can I get your name, please?");
        wait *;
    }   
    transitions 
    {

    }
}

digression how_may_i_help
{
    conditions {on #messageHasData("first_name");} 
    do 
    {
        set $first_name =  #messageGetData("first_name")[0]?.value??"";
        set $last_name =  #messageGetData("last_name")[0]?.value??"";
        #sayText("Hi " + $first_name + "! How may I help you out today?");
        wait *;
    }
}

digression internet_inquiry

{
    conditions {on #messageHasIntent("internet_inquiry");} 
    do
    {
        #sayText("I will be glad to answer your questions and help you with the new account setup. To suggest the best plans, may I know how do you use the internet? Like heavy usage or gaming, streaming, or heavy downloads? Or you can tell me how many devices you will be connecting at the same time?");
        wait *;
    }   
    transitions
    {
        
        zip_code : goto zip_code on #messageHasData("number_of_devices");
    }
    onexit
    {
        zip_code : do {
        set $device_num =  #messageGetData("number_of_devices")[0]?.value??"";}
    }
} 

node zip_code
{
    do 
    {     
        set $device_num =  #messageGetData("number_of_devices")[0]?.value??"";
        #sayText("Alright, " + $device_num + "! Can you please help me with the zip code you will be moving to?"); 
        wait*;
    }
    transitions
    {
        best_offer_internet: goto best_offer_internet on #messageHasData("zip_code");
    }
}

node best_offer_internet
{
    do 
    {
        set $zip_code =  #messageGetData("zip_code")[0]?.value??"";
        #sayText("I have the best offer as per your requirement, it's called performance internet and it includes download speeds up to 100 Mbps and speed good for up to 5 devices at the same time.At the cost of 39.99 dollars per month for the first 12 months with no term agreement. The offer price already Includes 10 dollars per month automatic payments and paperless billing discount for 24 months.");
        wait *;
    }   
}

digression what_is_no_term_agreement
{
    conditions {on #messageHasIntent("what_is_no_term_agreement");} 
    do 
    {     
        #sayText("It means if you cancel the services there will be no termination fees or any charges"); 
        wait*;
    }
}

digression what_needed_for_internet_setup
{
    conditions {on #messageHasIntent("what_needed_for_internet_setup");} 
    do 
    {     
        #sayText("You'll need a modem. If you will lease a modem it will be for 14 dollars per month or you can also use your own modem. That's it. If your address will be eligible you can install the services yourself by plugging the modem only.");
        wait*;
    }

}

digression how_easy_to_setup_internet_myself
{
    conditions {on #messageHasIntent("how_easy_to_setup_internet_myself");} 
    do 
    {     
        #sayText("It will be easy. It can be done from your own device using the link xfinity dot com slash activate. Also you can call at 1 8 5 5 6 5 2 3 4 4 6 and our activation team will do it remotely for you.");
        wait*;
    }
}

digression grace_period
{
    conditions {on #messageHasIntent("grace_period");} 
    do 
    {     
        #sayText("Yes, you can complete the payment in 15 days of the bill generation without interruption of services. You can also select the promise to pay in such cases and there will be no disconnection or extra charges.");
        wait*;
    }
}

digression setup_timeline
{
    conditions {on #messageHasIntent("setup_timeline");} 
    do 
    {     
        #sayText("When you have the complete address, you can initiate the chat again to setup the account and select the shipment for the delivery of the equipment. The delivery will be completed within 3 to 5 days. For the same day you can collect the equipment from our nearest store to your address.");
        wait*;
    }
}

digression internet_outage_notification
{
    conditions {on #messageHasIntent("internet_outage_notification");} 
    do 
    {     
        #sayText("You will receive the notification on text or email in such cases");
        wait*;
    }
}

digression change_internet_plan
{
    conditions {on #messageHasIntent("change_internet_plan");} 
    do 
    {     
        #sayText("You can initiate a chat on the website and our team will help you lower down the bill or make any changes to the deal, and you can anytime upgrade or downgrade the services.");
        wait*;
    }
}

digression tv_access_with_internet
{
    conditions {on #messageHasIntent("tv_access_with_internet");} 
    do 
    {     
        #sayText("Let me share the bundle deals with you for internet and cable.");
        #waitForSpeech(4000);
        #sayText("So there's choice double pay which includes download speeds up to 100 Mbps and 10 plus local and regional channels. It'll be at the cost of 49.99 dollars per month for the first 12 months with No Term Agreement.");
        wait*;
    }
}

digression after_twelve_mos_payment
{
    conditions {on #messageHasIntent("after_twelve_mos_payment");} 
    do 
    {     
        #sayText("After 12 months the regular rate of 89.99 dollars per month will be applied. However, you can again enroll for the new promotions after 12 months.");
        wait*;
    }
}

digression after_twelve_mos_payment_internet
{
    conditions {on #messageHasIntent("after_twelve_mos_payment_internet");} 
    do 
    {     
        #sayText("For only the internet it will be 80.95 dollars per month.");
        wait*;
    }
}

digression prep_for_TV_setup
{
    conditions {on #messageHasIntent("prep_for_TV_setup");} 
    do 
    {     
        #sayText("You will only need to order the services and there is no preperations required. You’ll only be required to connect them to the outlets to activate them.");
        wait*;
    }
}

digression access_internet_through_tv
{
    conditions {on #messageHasIntent("access_internet_through_tv");} 
    do 
    {     
        #sayText("Yes, absolutely, you definitely can!");
        wait*;
    }
}


//final and additional 

digression can_help_else
{
    conditions {on #messageHasIntent("thank_you") or #messageHasIntent("got_you");} 
    do 
    {     
        #sayText("Is there anything else I can help you with today?"); 
        wait*;
    }
}


digression thats_it_bye
{
    conditions {on #messageHasIntent("that_would_be_it");}
    do 
    {     
        #sayText("No problem, happy to help. I hope you have a great rest of your day. Bye!"); 
        #disconnect();
        exit;
    }
}

digression can_help 
{
    conditions {on #messageHasIntent("need_help");} 
    do
    {
        #sayText("How can I help you?");
        wait*;
    }
}


// additional digressions 

digression how_are_you
{
    conditions {on #messageHasIntent("how_are_you");}
    do 
    {
        #sayText("I'm well, thank you!", repeatMode: "ignore");
        #repeat(); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node 
        return; // go back to the node from which we got distracted into the digression 
    }
}

digression bye 
{
    conditions { on #messageHasIntent("bye"); }
    do 
    {
        #sayText("Sorry we didn't see this through. Call back another time. Bye!");
        #disconnect();
        exit;
    }
}
