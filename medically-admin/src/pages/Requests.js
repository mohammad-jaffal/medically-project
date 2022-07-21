import DoctorInfo from "../components/DoctorInfo";
import DoctorRequest from "../components/DoctorRequest";
import Navbar from "../components/NavBar";

const Requests = () => {
    return (
        <div className="global-container">
            <Navbar />
            <div className="requests-body">
                <p className="block-title">Requests:</p>
                <input type="text" className="search-input" placeholder="Name / Email" />
                <DoctorRequest name={'first name'} email={'firstemail@gmail.com'} />
                {/* <DoctorInfo/> */}
            </div>
        </div>
    );
}

export default Requests;