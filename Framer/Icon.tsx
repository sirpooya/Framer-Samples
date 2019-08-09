import * as React from "react";
import { PropertyControls, ControlType } from "framer";
import { string } from "prop-types";
import styled from "styled-components"

const Container = styled.div`
  height: 100%;
  display: grid;
  align-items: center;
  justify-items: center;

  
  & > svg {fill: ${props => props.color};}

`

const icons = [
  {
    "name": "gear",
    "svg": <path d="M 10.804 1.67 C 11.175 0.505 12.825 0.505 13.196 1.67 L 13.604 2.953 C 14.002 4.203 15.476 4.738 16.583 4.033 L 17.691 3.329 C 18.722 2.672 19.99 3.724 19.534 4.859 L 19.007 6.174 C 18.523 7.38 19.299 8.719 20.585 8.899 L 21.915 9.086 C 23.134 9.257 23.424 10.887 22.34 11.468 L 21.124 12.12 C 19.984 12.731 19.715 14.248 20.577 15.214 L 21.517 16.268 C 22.334 17.183 21.502 18.608 20.304 18.347 L 19.013 18.067 C 17.737 17.789 16.541 18.789 16.589 20.094 L 16.64 21.484 C 16.685 22.705 15.135 23.262 14.392 22.293 L 13.587 21.244 C 12.786 20.201 11.214 20.201 10.413 21.244 L 9.608 22.293 C 8.865 23.262 7.315 22.705 7.36 21.484 L 7.411 20.094 C 7.459 18.789 6.263 17.789 4.987 18.067 L 3.696 18.347 C 2.498 18.608 1.666 17.183 2.483 16.268 L 3.423 15.214 C 4.285 14.248 4.016 12.731 2.876 12.12 L 1.66 11.468 C 0.576 10.887 0.866 9.257 2.085 9.086 L 3.415 8.899 C 4.701 8.719 5.477 7.38 4.993 6.174 L 4.466 4.859 C 4.01 3.724 5.278 2.672 6.309 3.329 L 7.417 4.033 C 8.524 4.738 9.998 4.203 10.396 2.953 Z M 9.203 12.089 C 9.203 13.654 10.455 14.924 12 14.924 C 13.545 14.924 14.797 13.654 14.797 12.089 C 14.797 10.523 13.545 9.253 12 9.253 C 10.455 9.253 9.203 10.523 9.203 12.089 Z" ></path>
  },
  {
    "name": "close",
    "svg" : <path d="M 4.939 1.5 L 12.08 9.701 L 19.778 2.017 L 22 4.236 L 14.147 12.075 L 21.433 20.442 L 19.061 22.5 L 11.92 14.299 L 4.222 21.983 L 2 19.764 L 9.853 11.925 L 2.567 3.558 Z" ></path>
  },
  {
    "name": "heart",
    "svg" : <path d="M 10.976 19.7 C 10.976 19.7 7.413 16.138 0.976 9.7 C -2.899 3.325 5.663 -3.112 10.976 2.2 C 16.851 -3.675 24.851 3.325 20.476 10.2 Z" ></path>
  },
]

var iconNames = []
for (var index = 0; index < icons.length; index++) {
  iconNames.push(icons[index]["name"])
}

interface Props {
  name: string;
  color: string;
} 

interface State {
  svg: any;
};


export class Icon extends React.Component<Props, State> {

  static defaultProps = {
    name: icons[0]["name"],
  }

  state = {
    svg: icons[0]["svg"]
  }

  static propertyControls: PropertyControls = {
    name: { type: ControlType.Enum,
    title: "Name",
    options: iconNames
    },
    color: {type: ControlType.String, title: "Color"}
  };

   render() {
     icons.map(icon => {
       if(icon.name == this.props.name) {
         this.state.svg = icon.svg
       }
     })
    return <Container>
      <svg fill={this.props.color} width="24" height="24">{this.state.svg}</svg>
    </Container>;
  }
}