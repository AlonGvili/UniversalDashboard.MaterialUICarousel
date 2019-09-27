import React from "react";
import { Slide } from 'material-auto-rotating-carousel'

const UDMUCarouselSlide = props => {
    const { media, ...attributes } = props
    const slideMedia = UniversalDashboard.renderComponent(media)
    return <Slide {...attributes} media={slideMedia} />
}

export default UDMUCarouselSlide