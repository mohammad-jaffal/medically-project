import Navbar from "../components/NavBar";

const Home = () => {
    return (
        <div className="global-container">
            <Navbar />
            <div className="home-body">
                <div className="filter-container">
                    <p className="block-title">Filter</p>
                    <select className="type-select">
                        <option value="1">User</option>
                        <option value="2">Doctor</option>
                    </select>
                </div>
                <div className="data-container">
                    <p className="block-title">Data</p>
                </div>
            </div>
        </div>
    );
}

export default Home;