import * as React from "react";
import { PropertyControls, ControlType, Size } from "framer";
import styled from "styled-components"
import { number } from "prop-types";

const Container = styled.div`
  display: grid;
  grid-template-columns: repeat(${props => props.columns}, 1fr);
  grid-template-rows: repeat(${props => props.rows}, 1fr);
  grid-gap: ${props => props.gap}px;
`
const Item = styled.div`
  width: ${props => props.width / props.columns}px;
  height: ${props => props.height / props.rows}px;

  div {
    width: ${props => props.width / props.columns}px !important;
    height: ${props => props.height / props.rows}px !important;
  }
`


interface Props extends Size = { 
  columns: number;
  rows: number;
  gap: number;
};

export class Grid extends React.Component<Props> {

  static defaultProps: Props = {
    columns: 3,
    rows: 5,
    gap: 1
  };

  static propertyControls: PropertyControls = {
    columns : {type: ControlType.Number, title: "Columns"},
    rows : {type: ControlType.Number, title: "Rows"},
    gap : {type: ControlType.Number, title: "Gap"}
  }

  render() {
    const max =  this.props.columns * this.props.rows
    var items = []
    for (var index = 0; index < max; index++) {
      items.push(<Item width={this.props.width} height={this.props.height} columns={this.props.columns}
        rows={this.props.rows}>{this.props.children}</Item>)
    }
    return <Container columns={this.props.columns}
    rows={this.props.rows} gap={this.props.gap}>{items}</Container>;
  }


}


