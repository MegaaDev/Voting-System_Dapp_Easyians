import React from "react";
import Frame from "./../assets/Frame.svg";
import Ellipse from "./../assets/ellipse.png";
import Mask from "./../assets/MetaMask.png";

const Login = (props) => {
  return (
    <div className="login-container">
      <div className="containers">
        <div>
          {" "}
          <div>
            <h1 className="welcome">Welcome</h1>
            <h1 className="welcome-message">Voting System Dapp</h1>
          </div>
          <button className="login-button btn" onClick={props.connectWallet}>
            <img className="logo" src={Mask} alt="" />
            Login Metamask
          </button>
        </div>

        <img src={Frame} alt="" />
        <img className="gradient" src={Ellipse} alt="" />
      </div>
    </div>
  );
};

export default Login;
