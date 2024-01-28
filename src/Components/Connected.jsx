import React from "react";

const Connected = (props) => {
  return (
    <div className="connected-container">
      <div className="left-container">
        {" "}
        <h1 className="connected-header">You are Connected to Wallet</h1>
        <p className="connected-account">Metamask Account: {props.account}</p>
        {/* <p className="connected-account">
          Remaining Time: {props.remainingTime}
        </p> */}
        {props.showButton === 1 ? (
          <p className="connected-account">You have already voted</p>
        ) : (
          <div className="votingSpace">
            <select
              value={props.number}
              className="selectStyle"
              onChange={props.handleNumberChange}
            >
              <option value="">Select Candidate Index</option>
              {props.candidates.map((candidate, index) => (
                <option key={index} value={candidate.index}>
                  {candidate.name}
                </option>
              ))}
            </select>
            <button className="vote-button" onClick={props.voteFunction}>
              Vote
            </button>
          </div>
        )}
      </div>
      <div className="right-container">
        <div className="table">
          <div className="titles">
            <p className="index">SN</p>
            <p className="candidate">Candidate</p>
            <p className="vote">Votes</p>
          </div>
          <div className="scrollable-content" id="style-1">
            {props.candidates.map((candidate, index) => (
              <div className="content " key={index}>
                <p className="index">{candidate.index + 1}</p>
                <p className="candidate">{candidate.name}</p>
                <p className="vote">{candidate.voteCount}</p>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Connected;
