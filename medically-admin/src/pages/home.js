import DoctorData from "../components/DoctorData";
import Navbar from "../components/NavBar";
import UserData from "../components/UserData";

const Home = () => {
    var type = 1;
    return (
        <div className="global-container">
            <Navbar />
            <div className="home-body">
                <div className="filter-container" >
                    <select className="type-select" onChange={() => { }}>
                        <option value="1">User</option>
                        <option value="2">Doctor</option>
                    </select>
                    {type == 2 &&
                        <div className="domains-filter">
                            <div className="domain-filter-item">domain 1</div>
                            <div className="domain-filter-item">domain 2</div>
                            <div className="domain-filter-item">domain 3</div>
                            <div className="domain-filter-item">domain 4</div>
                            <div className="domain-filter-item">domain 5</div>
                        </div>
                    }

                </div>
                <div className="data-container">
                    <input type="text" className="search-input" placeholder="Name / Email" />
                    {type == 2 && <DoctorData name={'first name'} email={'firstemail@gmail.com'} balance={'150'} domain={'example domain'} />}
                    {type == 1 && <UserData name={'first name'} email={'firstemail@gmail.com'} balance={'150'} />}

                </div>
            </div>
        </div>
    );
}

export default Home;