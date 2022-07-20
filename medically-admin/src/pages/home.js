import Navbar from "../components/NavBar";

const Home = () => {
    return (
        <div className="global-container">
            <Navbar />
            <div className="home-body">
                <div className="filter-container">
                    <p>Filter</p>
                </div>
                <div className="data-container">
                    <p>Data</p>
                </div>
            </div>
        </div>
    );
}

export default Home;