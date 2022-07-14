local Raycast = {}

    function Raycast.Cast(From : Vector3,Too : Vector3,MaxDistance : number,Ignore : table,IgnoreType : number) : RaycastResult
        assert(From,"[Refer][Raycast] Expected From got nil")
        assert(Too,"[Refer][Raycast] Expected Too got nil")
        assert(MaxDistance,"[Refer][Raycast] Expected MaxDistance got nil")

        assert(typeof(From) == "Vector3",("[Refer][Raycast] Expected From of Type Vector3 got %s"):format(typeof(From)))
        assert(typeof(Too) == "Vector3",("[Refer][Raycast] Expected Too of Type Vector3 got %s"):format(typeof(Too)))
        assert(typeof(MaxDistance) == "number",("[Refer][Raycast] Expected From of Type Number got %s"):format(typeof(MaxDistance)))

        local dir = (From-Too).Unit

        local params = RaycastParams.new()
        params.FilterType = (if IgnoreType == 1 then Enum.RaycastFilterType.Blacklist else Enum.RaycastFilterType.Whitelist)
        params.FilterDescendantsInstances = Ignore or {}

        local RaycastResult = workspace:Raycast(From,dir*MaxDistance,params)

        return RaycastResult
    end

    function Raycast.GetIntersectionEnd(Point : Vector3,Direction : Vector3,Part : BasePart) : Vector3
        assert(Point,"[Refer][Raycast] Expected Point got nil")
        assert(Direction,"[Refer][Raycast] Expected Direction got nil")
        assert(Part,"[Refer][Raycast] Expected MaxDistance Part nil")

        assert(typeof(Point) == "Vector3",("[Refer][Raycast] Expected Point of Type Vector3 got %s"):format(typeof(Point)))
        assert(typeof(Direction) == "Vector3",("[Refer][Raycast] Expected Direction of Type Vector3 got %s"):format(typeof(Direction)))
        assert(typeof(Part) == "Instance",("[Refer][Raycast] Expected Part of Type Instance got %s"):format(typeof(Part)))

        local MaxDistance = 500

        local StartPoint = Point + (Direction * MaxDistance)

        local Result = Raycast.Cast(StartPoint,Point,MaxDistance*2,{Part},2)

        assert(Result, "[Refer][Raycast] Expected result from raycast, please check all the parameters you have put in are correct.")

        return Result.Position
    end

return Raycast