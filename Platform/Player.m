classdef Player
    %Players will have all these attributes that can go here
    %   Gathered information will contribute to the player class
    
    properties
        Name
        VPIP
        PFR
        AFq
        Pre3Bet
        PreF3Bet
        CC
        ST
        FST
        FlopCBet
        FlopFCBet
        FlopRBet
        TurnCBet
        TurnFCBet
        TurnAFq
        RiverBet
        RiverFBet
        HandsPlayed
        VPIPCount
        PFRCount
        Pre3BetCount
        Pre3BetOpportunities
        AggressionCount
        AgressionOpportunities
        
        
    end
    
    methods
        function calcVPIP = findVPIP(obj)
            calcVPIP = [obj.VPIPCount]./[obj.HandsPlayed];
        end
        function calcPFR = findPFR(obj)
            calcPFR = [obj.PFRCount]./[obj.HandsPlayed];
        end
    end
    
end

