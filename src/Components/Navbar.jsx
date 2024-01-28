function Navbar(props) {
  return (
    <div className="nav">
      <h1>EASYIANS</h1>
      <div className="links">
        <p>About</p>
        <p>Github</p>
        <p
          className="host"
          onClick={() => {
            props.setHost(true);
          }}
        >
          Host Election
        </p>
      </div>
    </div>
  );
}

export default Navbar;
