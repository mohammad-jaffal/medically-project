import Navbar from "../components/NavBar";

const AddDomain = () => {
    return (
        <div className="global-container">
            <Navbar />
            <div className="add-domain-body">
                <p>Add Domain:</p>
                <div className="domain-input-container">
                    <input type="text" className="domain-input" required />
                    <button className="admin-btn">Add</button>
                </div>
                
            </div>
        </div>
    );
}

export default AddDomain;