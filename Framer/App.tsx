import { Data, animate, Override, Animatable } from "framer"
import { Curve } from "framer";

const springOptions = { tension: 500,  friction: 30 }

const bezierCurve = [0.2, 0.8, 0.2, 1] as Curve
const duration = 0.5
const bezierOptions = { curve: bezierCurve, duration }

const data = Data({ 
    left: Animatable(52),
    right: Animatable(52),
    top: Animatable(132),
    bottom: Animatable(300),
    cardOpen: false,
    opacity: Animatable(0),
    menuOpacity: Animatable(1),
    appearance: "Dark",
    
     })

export const CardOverride: Override = () => {
    return {
        left: data.left,
        right: data.right,
        top: data.top,
        bottom: data.bottom,
        onTap() {
            // data.scale.set(0.6)
            data.cardOpen = !data.cardOpen
            if(data.cardOpen) {
                animate.spring(data.left, 10, springOptions)
                animate.spring(data.right, 10, springOptions)
                animate.spring(data.top, 100, springOptions)
                animate.spring(data.bottom, 0, springOptions)
                animate.bezier(data.opacity, 1, bezierOptions)
                animate.bezier(data.menuOpacity, 0, bezierOptions)
                appearance = "Dark"

            } else {
                animate.spring(data.left, 52, springOptions)
                animate.spring(data.right, 52, springOptions)
                animate.spring(data.top, 76, springOptions)
                animate.spring(data.bottom, 400, springOptions)      
                animate.bezier(data.opacity, 0, bezierOptions)     
                animate.bezier(data.menuOpacity, 1, bezierOptions)
                appearance = "Dark"     
            }

        },
    }
}

    export const BackgroundOverride: Override = () => {
        return {
            opacity: data.opacity
        }
    }

    export const MenuOverride: Override = () => {
        return {
            opacity: data.menuOpacity
        }
    }

    export const AppereanceOverride: Override = () => {
        return {
            appearance: data.appearance
        }
    }
