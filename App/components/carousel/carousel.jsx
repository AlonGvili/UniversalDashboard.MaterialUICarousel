import React from "react";
import { AutoRotatingCarousel } from 'material-auto-rotating-carousel'
import useDashboardEvent from '../hooks/useDashboardEvent'

const UDMUCarousel = props => {
    const [state, reload] = useDashboardEvent(props.id, props)
    const { content, attributes } = state
    let open = attributes.open
    const carouselContent = UniversalDashboard.renderComponent(content)

    const onCloseEvent = () => {
        UniversalDashboard.publish("element-event", {
            type: "clientEvent",
            eventId: props.id + "onClose",
            eventName: "onClose",
            eventData: ''
        });
        open = false
    }

    const onStartEvent = () => {
        UniversalDashboard.publish("element-event", {
            type: "clientEvent",
            eventId: props.id + "onStart",
            eventName: "onStart",
            eventData: ''
        });
        console.log('carousel on start event')
    }
    
    console.log('carousel: ', attributes)
    return <AutoRotatingCarousel {...attributes} open={open} onClose={onCloseEvent} onStart={onStartEvent} ButtonProps={{...attributes.ButtonProps}}>
        {carouselContent}
    </AutoRotatingCarousel>
}

export default UDMUCarousel