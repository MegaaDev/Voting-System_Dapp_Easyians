function Navbar(props) {
  return (
    <div className="nav">
      <h1>EASYIANS</h1>
      <div className="links">
        <a href="https://drive.google.com/drive/u/0/home">
          <p>About</p>
        </a>

        <a
          className="atag"
          href="https://github.com/MegaaDev/Voting-System_Dapp_Easyians"
        >
          <p>Github</p>
        </a>
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
