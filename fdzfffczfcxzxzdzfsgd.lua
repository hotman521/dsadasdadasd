local frameToTrack = GUI["2"]
local scrollingFrame = Tab["8"]
local scrollingFrame2 = Tab["41"]

local function updateScrollingFrameSize()
    local totalHeight = 0
    for _, item in ipairs(scrollingFrame:GetChildren()) do
        if item:IsA("Frame") then
            totalHeight = totalHeight + item.AbsoluteSize.Y + 10
        end
    end
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)

    local totalHeight2 = 0
    for _, item in ipairs(scrollingFrame2:GetChildren()) do
        if item:IsA("Frame") then
            totalHeight2 = totalHeight2 + item.AbsoluteSize.Y + 10
        end
    end
    scrollingFrame2.CanvasSize = UDim2.new(0, 0, 0, totalHeight2)

    scrollingFrame.ScrollBarImageTransparency = scrollingFrame.CanvasSize.Y.Offset <= scrollingFrame.AbsoluteSize.Y and 1 or 0
    scrollingFrame2.ScrollBarImageTransparency = scrollingFrame2.CanvasSize.Y.Offset <= scrollingFrame2.AbsoluteSize.Y and 1 or 0
end

frameToTrack:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScrollingFrameSize)

scrollingFrame.ChildAdded:Connect(updateScrollingFrameSize)
scrollingFrame.ChildRemoved:Connect(updateScrollingFrameSize)

scrollingFrame2.ChildAdded:Connect(updateScrollingFrameSize)
scrollingFrame2.ChildRemoved:Connect(updateScrollingFrameSize)

-- Call the function once at the start
updateScrollingFrameSize()
