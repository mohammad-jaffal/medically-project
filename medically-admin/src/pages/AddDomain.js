import Navbar from "../components/NavBar";

const AddDomain = () => {
    return (
        <div className="global-container">
            <Navbar />
            <div className="add-domain-body">
                <p className="block-title">Add Domain:</p>
                <div className="domain-input-container">
                    <input type="text" className="domain-input" required />
                    <button className="admin-btn">Add</button>
                </div>
                <p className="block-title">Available Domains:</p>
                <ul className="domains-container">
                    <li className="domain-card"><span>domain 1</span></li>
                    <li className="domain-card"><span>domain 2</span></li>
                    <li className="domain-card"><span>domain 3</span></li>
                    <li className="domain-card"><span>domain 4</span></li>
                    <li className="domain-card"><span>domain 5</span></li>
                </ul>
            </div>
        </div>
    );
}

export default AddDomain;