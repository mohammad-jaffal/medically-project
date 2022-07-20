import Navbar from "../components/NavBar";
import UserData from "../components/UserData";

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
                    <div className="domains-filter">
                        <div className="domain-filter-item">domain 1</div>
                        <div className="domain-filter-item">domain 2</div>
                        <div className="domain-filter-item">domain 3</div>
                        <div className="domain-filter-item">domain 4</div>
                        <div className="domain-filter-item">domain 5</div>
                    </div>
                </div>
                <div className="data-container">
                    <div className="results-header">
                        <p className="block-title">Data</p>
                        <input type="text" className="search-input" placeholder="Name / Email" />
                    </div>
                    <UserData name={'first name'} email={'firstemail@gmail.com'} balance={'150'}/>

                </div>
            </div>
        </div>
    );
}

export default Home;