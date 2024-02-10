local countdownStarted = false

function onInit()
    print("BTNCountdown Loaded!")
    MP.RegisterEvent("onChatMessage", "onChatMessage")
    MP.RegisterEvent("onCountdownRequested", "startCountdown")
end

function onChatMessage(senderID, name, message)
    if message == "/countdown" then
        if not countdownStarted then
            MP.SendChatMessage(-1, "Race is about to start!")
            MP.TriggerGlobalEvent("onCountdownRequested")
        else
            MP.SendChatMessage(senderID, "Countdown is already in progress.")
        end
        return 1
    elseif message == "/coords" then
        displayCurrentCoordinates()
        return 1
    end
end

function startCountdown()
    -- Ensure countdown is not started multiple times
    if not countdownStarted then
        countdownStarted = true

        local length = 5 --Adjust this to increase the amount of time allowed for countdown

        for i = 0, length do
            if i < length then
                MP.SendChatMessage(-1, "Race Starts in " .. length - i)
            end

            if i == length then
                MP.SendChatMessage(-1, "Go!")
            end
            MP.Sleep(1000)
        end

        countdownStarted = false -- Reset countdown flag after countdown finishes
    end
end